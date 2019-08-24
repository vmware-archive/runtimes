FROM microsoft/dotnet:2.1-sdk

WORKDIR /app

RUN dotnet new classlib -n project -o .
RUN dotnet add package Kubeless.Functions
RUN dotnet restore

RUN mv /root/.dotnet /root/.nuget /
RUN mkdir /.local/
RUN chown 1000 /.dotnet /.nuget /.nuget/packages /.local

ADD compile-function.sh .