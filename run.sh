#!/usr/bin/env bash

. ./run.conf

function get_items(){
    LIST="${1}"
    # DELIM=','
    DELIM="${2}"
    echo -n ${LIST} | sed "s/\[//g" | sed "s/\]//g" | sed "s/\"//g" #| sed "s/${DELIM}/\n/g"
}

# get_items ${GITLAB_EE_VERSION} " "

for i in ${GITLAB_EE_VERSION//,/ }; do 
    echo $i;     
done

S1="https://packages.gitlab.com/gitlab/gitlab-ee/packages/el/8/gitlab-ee-${version}-ee.0.el8.x86_64.rpm/download.rpm"
lastToken="${S1##*/}"
echo "$lastToken"


