#!/bin/sh
tag=$(cat ../../CURRENT_TAG)

docker build .. --platform linux/arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-basic.profile" --tag rzippo/texlive-basic-arm64:$tag $@;
docker build .. --platform linux/arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-small.profile" --tag rzippo/texlive-small-arm64:$tag $@;
docker build .. --platform linux/arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-medium.profile" --tag rzippo/texlive-medium-arm64:$tag $@;
docker build .. --platform linux/arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-full.profile" --tag rzippo/texlive-full-arm64:$tag $@;
