#!/bin/sh

cp /kubeless/publish/*.dll /app
dotnet --additional-deps $KUBELESS_INSTALL_VOLUME/publish/*.deps.json --additionalprobingpath $KUBELESS_INSTALL_VOLUME/packages /app/Kubeless.WebAPI.dll
