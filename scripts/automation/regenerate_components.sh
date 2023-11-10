#!/bin/bash

source config.env

echo "Regenerating ${COMPONENT_DEFINITION}" 
trestle author component-generate --name $COMPONENT_DEFINITION --output md_components/$COMPONENT_DEFINITION
