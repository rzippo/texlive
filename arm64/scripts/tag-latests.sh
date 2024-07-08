#!/bin/sh
tag=$(cat ../../CURRENT_TAG)

docker tag rzippo/texlive-basic-arm64:$tag rzippo/texlive-basic-arm64:latest;
docker tag rzippo/texlive-small-arm64:$tag rzippo/texlive-small-arm64:latest;
docker tag rzippo/texlive-medium-arm64:$tag rzippo/texlive-medium-arm64:latest;
docker tag rzippo/texlive-full-arm64:$tag rzippo/texlive-full-arm64:latest;
