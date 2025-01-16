#!/usr/bin/env bash

OS=Linux       # or Darwin, Windows
VERSION=$(curl -s "https://api.github.com/repos/google/go-containerregistry/releases/latest" | jq -r '.tag_name')
# VERSION=vX.Y.Z
ARCH=x86_64    # or arm64, x86_64, armv6, i386, s390x
curl -sL "https://github.com/google/go-containerregistry/releases/download/${VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" > go-containerregistry.tar.gz