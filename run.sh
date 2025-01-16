#!/usr/bin/env bash

. ./run.conf

echo $ANSIBLE_VERSION | jq .[0]
echo $GITLAB_EE_VERSION | jq .[0]