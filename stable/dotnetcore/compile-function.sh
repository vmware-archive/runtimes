#!/bin/bash

# kubeless function directory
PROJECT_MOUNT=$1
echo Mount $PROJECT_MOUNT

# detect language
if [[ -s $PROJECT_MOUNT/*cs* ]]; then
	LANGUAGE=cs;
elif [[ -s $PROJECT_MOUNT/*fs* ]]; then
	LANGUAGE=fs;
else
	LANGUAGE=vb;
fi
echo Language $LANGUAGE

# set project files variables
PACKAGES_DIR=$PROJECT_MOUNT/packages
USER_PROJ=$PROJECT_MOUNT/project.${LANGUAGE}proj
DEFAULT_CSPROJ=/app/project.csproj 

# copy a default project file if not present
if [ -s $USER_PROJ ]; then
	echo Project file is here;
else
	cp $DEFAULT_CSPROJ $USER_PROJ
fi

# compile
dotnet restore $USER_PROJ --packages $PACKAGES_DIR
dotnet publish $USER_PROJ -o publish -c Release --no-restore
