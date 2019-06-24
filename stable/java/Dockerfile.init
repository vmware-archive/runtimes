FROM openjdk:8-jdk

RUN apt update && apt install maven -y

COPY . /usr/src/myapp
COPY compile-function.sh /
