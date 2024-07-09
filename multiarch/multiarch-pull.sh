#!/bin/sh
tag=$(cat ../CURRENT_TAG)

docker pull rzippo/texlive-basic:$tag;
docker pull rzippo/texlive-basic:latest;

docker pull rzippo/texlive-small:$tag;
docker pull rzippo/texlive-small:latest;

docker pull rzippo/texlive-medium:$tag;
docker pull rzippo/texlive-medium:latest;

docker pull rzippo/texlive-full:$tag;
docker pull rzippo/texlive-full:latest;
