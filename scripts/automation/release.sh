#!/bin/bash

source config.env

COUNT_COMPONENT_DEFINITIONS=$(ls -l component-definitions | grep ^- | wc -l)
COUNT_COMPONENT_DEFINITIONS_MD=$(ls -l md_components | grep ^- | wc -l)
if [ "$COUNT_COMPONENT_DEFINITIONS" == "0" ] || [ "$COUNT_COMPONENT_DEFINITIONS_MD" == "0" ]
then
    echo "no component-definition or markdown present -> nothing to do"
else
    version_tag=$(semantic-release print-version)
	echo "Bumping version of component-definitions to ${version_tag}" 
	export VERSION_TAG="$version_tag"
	echo "VERSION_TAG=${VERSION_TAG}" >> $GITHUB_ENV
	COUNT=$(ls -l md_components | grep ^- | wc -l)
	if [ $COUNT -lt 1 ]
	then
		./scripts/automation/regenerate_components.sh 
	fi
	./scripts/automation/assemble_components.sh $version_tag
	git config --global user.email "$EMAIL"
	git config --global user.name "$NAME" 
	semantic-release publish
fi
