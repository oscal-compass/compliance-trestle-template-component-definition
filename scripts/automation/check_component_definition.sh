#!/bin/bash

source config.env

RESULT=$(ls component-definitions)

if [[ "$RESULT" == *"$COMPONENT_DEFINITION"* ]]; then
  echo "component-definition exists, exit 1";
  exit 1;
else
  echo "component-definition does not exist, exit 0"
  exit 0;
fi
