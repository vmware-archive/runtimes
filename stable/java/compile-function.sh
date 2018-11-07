#!/bin/sh

set -e

if [[ -s /kubeless/pom.xml ]]; then
  mv /kubeless/pom.xml /kubeless/function-pom.xml
fi

cp -r /usr/src/myapp/* /kubeless/
cp /kubeless/*.java /kubeless/function/src/main/java/io/kubeless/
cp /kubeless/function-pom.xml /kubeless/function/pom.xml 2>/dev/null || true
mvn package > /dev/termination-log 2>&1 && mvn install > /dev/termination-log 2>&1
