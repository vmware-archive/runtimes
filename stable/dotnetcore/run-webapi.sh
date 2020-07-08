#!/bin/sh

# If ASSEMBLY_NAME is not set, detect automatically from csproj filename
export ASSEMBLY_NAME="${ASSEMBLY_NAME:=$(basename /kubeless/*.csproj .csproj)}"

cp /kubeless/publish/*.dll /app
cp /kubeless/publish/*.pdb /app
dotnet --additional-deps $KUBELESS_INSTALL_VOLUME/publish/*.deps.json --additionalprobingpath $KUBELESS_INSTALL_VOLUME/packages /app/Kubeless.WebAPI.dll
