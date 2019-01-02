package io.kubeless;

import static java.lang.Thread.sleep;

public class Example {
    public String sayHello(io.kubeless.Event event, io.kubeless.Context context) {
        try {
            sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return event.Data;
    }
}
