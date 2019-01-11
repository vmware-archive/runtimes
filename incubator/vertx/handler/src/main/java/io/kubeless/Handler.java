package io.kubeless;

import io.prometheus.client.Counter;
import io.prometheus.client.Histogram;
import io.vertx.core.AbstractVerticle;
import io.vertx.core.Future;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpServerRequest;
import io.vertx.core.http.HttpServerResponse;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.BodyHandler;
import org.apache.log4j.BasicConfigurator;
import org.apache.log4j.Logger;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import static io.vertx.ext.web.handler.TimeoutHandler.create;
import static java.lang.String.format;

public class Handler {

    static String className   = System.getenv("MOD_NAME");
    static String methodName  = System.getenv("FUNC_HANDLER");
    static String timeout     = System.getenv("FUNC_TIMEOUT");
    static String runtime     = System.getenv("FUNC_RUNTIME");
    static String memoryLimit = System.getenv("FUNC_MEMORY_LIMIT");
    static Method method;
    static Object obj;
    static Logger logger = Logger.getLogger(Handler.class.getName());

    static final Counter requests = Counter.build().name("function_calls_total").help("Total function calls.").register();
    static final Counter failures = Counter.build().name("function_failures_total").help("Total function call failuress.").register();
    static final Histogram requestLatency = Histogram.build().name("function_duration_seconds").help("Duration of time user function ran in seconds.").register();


    public static void main(String[] args) {
        BasicConfigurator.configure();
        Vertx vertx = Vertx.vertx();
        vertx.deployVerticle(new KubelessVerticle());
    }

    static class KubelessVerticle extends AbstractVerticle {

        @Override
        public void start(final Future<Void> future) {
            String funcPort = System.getenv("FUNC_PORT");
            if(funcPort == null || funcPort.isEmpty()) {
                funcPort = "8080";
            }
            try {
                int port = Integer.parseInt(funcPort);
                final Router router = Router.router(vertx);
                logger.info(format("timeout is %s seconds", timeout));
                router.route("/").handler(create(Long.valueOf(timeout)*1000));
                router.route("/").handler(BodyHandler.create());
                router.route("/").blockingHandler(this::handleRequest).failureHandler(this::handleFailure);
                router.route("/healthz").handler(this::handleHealth);
                vertx.createHttpServer()
                    .requestHandler(router::accept)
                    .listen(
                        config()
                            .getInteger("http.port", port),
                            result -> {
                                if (result.succeeded()) {
                                    future.complete();
                                } else {
                                    future.fail(result.cause());
                                }
                            });
                final Class<?> c = Class.forName("io.kubeless."+className);
                obj = c.newInstance();
                method = c.getMethod(methodName, io.kubeless.Event.class, io.kubeless.Context.class);
            } catch (Exception e) {
                failures.inc();
                if (e instanceof ClassNotFoundException) {
                    logger.error("Class: " + className + " not found");
                } else if (e instanceof NoSuchMethodException) {
                    logger.error("Method: " + methodName + " not found");
                } else {
                    logger.error("An exception occured running Class: " + className + " method: " + methodName);
                    e.printStackTrace();
                }
            }
        }

        private void handleRequest(final RoutingContext routingContext) {
            final Histogram.Timer requestTimer = requestLatency.startTimer();
            final HttpServerResponse response = routingContext.response();
            try {
                requests.inc();
                final HttpServerRequest request = routingContext.request();

                final String eventId = request.getHeader("event-id");
                final String eventType = request.getHeader("event-type");
                final String eventTime = request.getHeader("event-time");
                final String eventNamespace = request.getHeader("event-namespace");

                final Event event = new Event(routingContext.getBodyAsString(), eventId, eventType, eventTime, eventNamespace);
                final Context context = new Context(methodName, timeout, runtime, memoryLimit);

                final Object returnValue = Handler.method.invoke(Handler.obj, event, context);
                final String res = (String) returnValue;
                logger.info("Response: " + res);
                response.setStatusCode(200).end(res);
            } catch (Exception e) {
                failures.inc();
                if (e instanceof InvocationTargetException) {
                    logger.error("Failed to Invoke Method: " + methodName);
                    logger.error(e.getCause());
                } else {
                    logger.error("An exception occured running Class: " + className + " method: " + methodName);
                    e.printStackTrace();
                }
                response.setStatusCode(500).end("Error: 500 Internal Server Error");

            } finally {
                requestTimer.observeDuration();
                logger.info("Execution time was " + requestTimer.observeDuration());
            }
        }

        private void handleHealth(final RoutingContext context) {
            context.response()
                    .setStatusCode(200)
                    .end("OK");
        }

        private void handleFailure(final RoutingContext context) {
            context.response()
                    .setStatusCode(408)
                    .end("Timeout");
        }

        @Override
        public void stop() {
            logger.info("Shutting down application");
            vertx.close();
        }
    }
}
