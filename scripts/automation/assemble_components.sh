#!/bin/bash

source config.env

version_tag=$1
if [ ${version_tag} != "" ]; then 
	echo "Assembling ${COMPONENT_DEFINITION} with version ${version_tag}"
	trestle author component-assemble --markdown md_components/$COMPONENT_DEFINITION --output $COMPONENT_DEFINITION --version $version_tag 
else
	echo "Assembling ${COMPONENT_DEFINITION}"
	trestle author component-assemble --markdown md_components/$COMPONENT_DEFINITION --output $COMPONENT_DEFINITION
fi
