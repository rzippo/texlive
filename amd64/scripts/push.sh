#!/bin/sh

# requires docker login beforehand
tag=$(cat ../../CURRENT_TAG)

docker push rzippo/texlive-basic-amd64:$tag;
docker push rzippo/texlive-basic-amd64:latest;

docker push rzippo/texlive-small-amd64:$tag;
docker push rzippo/texlive-small-amd64:latest;

docker push rzippo/texlive-medium-amd64:$tag;
docker push rzippo/texlive-medium-amd64:latest;

docker push rzippo/texlive-full-amd64:$tag;
docker push rzippo/texlive-full-amd64:latest;
