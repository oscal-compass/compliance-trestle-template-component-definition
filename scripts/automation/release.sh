#!/bin/bash
set -eo pipefail

source config.env

COUNT_COMPONENT_DEFINITIONS=$(ls -1 component-definitions | wc -l)
COUNT_COMPONENT_DEFINITIONS_MD=$(ls -1 md_components | wc -l)
if [ "$COUNT_COMPONENT_DEFINITIONS" == "0" ] || [ "$COUNT_COMPONENT_DEFINITIONS_MD" == "0" ]
then
    echo "no component-definition or markdown present -> nothing to do"
else
	next_version=$(semantic-release version --print 2>/dev/null || true)
	last_version=$(semantic-release version --print-last-released 2>/dev/null || true)
	# Match v7: empty VERSION_TAG when nothing to release.
	# Untagged repos: PSR prints 0.0.0 with no bump commits — skip that stamp.
	if [ "$next_version" = "$last_version" ] || { [ -z "$last_version" ] && [ "$next_version" = "0.0.0" ]; }; then
		version_tag=""
	else
		version_tag="$next_version"
	fi
	echo "Bumping version of component-definitions to ${version_tag}" 
	export VERSION_TAG="$version_tag"
	echo "VERSION_TAG=${VERSION_TAG}" >> $GITHUB_ENV
	COUNT=$(ls -1 md_components | wc -l)
	if [ $COUNT -lt 1 ]
	then
		./scripts/automation/regenerate_components.sh 
	fi
	./scripts/automation/assemble_components.sh $version_tag
	git config --global user.email "$EMAIL"
	git config --global user.name "$NAME"
	# --no-push/--no-vcs-release: push.sh commits component updates and moves the tag.
	if [ -n "$version_tag" ]; then
		semantic-release version --no-push --no-vcs-release
	fi
fi
