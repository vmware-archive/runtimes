#!/bin/bash

exit_on_error() {
    exit_code=$?
    last_command=$(fc -ln -1 | awk '{$1=$1};1')
    if [ $exit_code -ne 0 ]; then
        echo "\"${last_command}\" command failed with exit code ${exit_code}."
        exit $exit_code
    fi
}

# kubeless function directory
PROJECT_MOUNT=$1
echo Mount $PROJECT_MOUNT

# detect language
if [[ -s $PROJECT_MOUNT/module.cs ]]; then
	LANGUAGE=cs;
elif [[ -s $PROJECT_MOUNT/module.fs ]]; then
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
exit_on_error
dotnet publish $USER_PROJ -o publish -c Release --no-restore
exit_on_error