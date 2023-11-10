#!/bin/bash

source config.env

version_tag=$(semantic-release print-version)
echo "Bumping version of components to ${version_tag}" 
export VERSION_TAG="$version_tag"
echo "VERSION_TAG=${VERSION_TAG}" >> $GITHUB_ENV

COUNT=$(ls -l md_components | grep ^- | wc -l)
if [ $COUNT -lt 1 ]
then
	./scripts/automation/regenerate_components.sh $version_tag
fi

./scripts/automation/assemble_components.sh $version_tag
git config --global user.email "$EMAIL"
git config --global user.name "$NAME" 
semantic-release publish
