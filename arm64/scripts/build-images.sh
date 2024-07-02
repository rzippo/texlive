#!/bin/sh

docker build .. --platform linux/arm64 --file ../Dockerfile-arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-basic.profile" --tag rzippo/texlive-basic:july-2024;
docker build .. --platform linux/arm64 --file ../Dockerfile-arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-small.profile" --tag rzippo/texlive-small:july-2024;
docker build .. --platform linux/arm64 --file ../Dockerfile-arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-medium.profile" --tag rzippo/texlive-medium:july-2024;
docker build .. --platform linux/arm64 --file ../Dockerfile-arm64 --build-arg="TEXLIVE_PROFILE=./profiles/texlive-full.profile" --tag rzippo/texlive-full:july-2024 --no-cache;
