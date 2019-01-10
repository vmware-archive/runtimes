# Stable
local ballerina = import "./stable/ballerina/ballerina.jsonnet";
local dotnetcore = import "./stable/dotnetcore/dotnetcore.jsonnet";
local golang = import "./stable/golang/golang.jsonnet";
local java = import "./stable/java/java.jsonnet";
local nodejs = import "./stable/nodejs/nodejs.jsonnet";
local php = import "./stable/php/php.jsonnet";
local python = import "./stable/python/python.jsonnet";
local ruby = import "./stable/ruby/ruby.jsonnet";

# Incubator
local jvm = import "./incubator/jvm/jvm.jsonnet";
local nodejs_distroless = import "./incubator/nodejs_distroless/nodejs_distroless.jsonnet";
local nodejs_ce = import "./incubator/nodejs_ce/nodejs_ce.jsonnet";
local verxt = import "./incubator/vertx/verxt.jsonnet";

[ 
  # Stable
  ballerina,
  dotnetcore,
  golang,
  java,
  nodejs,
  php,
  python,
  ruby,
  # Incubator
  jvm,
  nodejs_distroless,
  nodejs_ce,
  vertx,
]
