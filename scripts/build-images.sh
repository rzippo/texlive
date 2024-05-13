#!/bin/sh

docker build .. --build-arg="TEXLIVE_PROFILE=./profiles/texlive-basic.profile" --tag rzippo/texlive-basic:may-2024;
docker build .. --build-arg="TEXLIVE_PROFILE=./profiles/texlive-small.profile" --tag rzippo/texlive-small:may-2024;
docker build .. --build-arg="TEXLIVE_PROFILE=./profiles/texlive-medium.profile" --tag rzippo/texlive-medium:may-2024;
docker build .. --build-arg="TEXLIVE_PROFILE=./profiles/texlive-full.profile" --tag rzippo/texlive-full:may-2024;
