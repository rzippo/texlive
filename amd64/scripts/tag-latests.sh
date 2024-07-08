#!/bin/sh
tag=$(cat ../../CURRENT_TAG)

docker tag rzippo/texlive-basic-amd64:$tag rzippo/texlive-basic-amd64:latest;
docker tag rzippo/texlive-small-amd64:$tag rzippo/texlive-small-amd64:latest;
docker tag rzippo/texlive-medium-amd64:$tag rzippo/texlive-medium-amd64:latest;
docker tag rzippo/texlive-full-amd64:$tag rzippo/texlive-full-amd64:latest;
