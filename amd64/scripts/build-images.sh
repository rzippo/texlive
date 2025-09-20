#!/bin/sh
tag=$(cat ../../CURRENT_TAG)

docker build .. --platform linux/amd64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-basic.profile" --tag rzippo/texlive-basic-amd64:$tag $@;
docker build .. --platform linux/amd64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-small.profile" --tag rzippo/texlive-small-amd64:$tag $@;
docker build .. --platform linux/amd64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-medium.profile" --tag rzippo/texlive-medium-amd64:$tag $@;
docker build .. --platform linux/amd64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-full.profile" --tag rzippo/texlive-full-amd64:$tag $@;
