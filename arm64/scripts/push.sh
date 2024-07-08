#!/bin/sh

# requires docker login beforehand
tag=$(cat ../../CURRENT_TAG)

docker push rzippo/texlive-basic-arm64:$tag;
docker push rzippo/texlive-basic-arm64:latest;

docker push rzippo/texlive-small-arm64:$tag;
docker push rzippo/texlive-small-arm64:latest;

docker push rzippo/texlive-medium-arm64:$tag;
docker push rzippo/texlive-medium-arm64:latest;

docker push rzippo/texlive-full-arm64:$tag;
docker push rzippo/texlive-full-arm64:latest;
