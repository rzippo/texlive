#!/bin/sh
tag=$(cat CURRENT_TAG)

docker tag rzippo/texlive-basic:$tag rzippo/texlive-basic:latest;
docker tag rzippo/texlive-small:$tag rzippo/texlive-small:latest;
docker tag rzippo/texlive-medium:$tag rzippo/texlive-medium:latest;
docker tag rzippo/texlive-full:$tag rzippo/texlive-full:latest;
