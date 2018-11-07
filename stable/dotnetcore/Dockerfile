# Image used only for build process
FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY ./src/Kubeless.Core/*.csproj ./Kubeless.Core/
COPY ./src/Kubeless.Functions/*.csproj ./Kubeless.Functions/
COPY ./src/Kubeless.WebAPI/*.csproj ./Kubeless.WebAPI/
RUN dotnet restore ./Kubeless.WebAPI/

# Copy everything else and build in release mode
COPY ./src/ ./
RUN dotnet publish ./Kubeless.WebAPI/ -c Release -o out

# Build runtime image
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/Kubeless.WebAPI/out .
# Kubeless.Functions reference
COPY --from=build-env /app/Kubeless.WebAPI/out/Kubeless.Functions.dll /usr/share/dotnet/store/x64/netcoreapp2.0/.

ENTRYPOINT ["dotnet", "Kubeless.WebAPI.dll"]