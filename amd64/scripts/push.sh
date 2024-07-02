#!/bin/sh

# requires docker login beforehand
tag=$(cat CURRENT_TAG)

docker push rzippo/texlive-basic:$tag;
docker push rzippo/texlive-basic:latest;

docker push rzippo/texlive-small:$tag;
docker push rzippo/texlive-small:latest;

docker push rzippo/texlive-medium:$tag;
docker push rzippo/texlive-medium:latest;

docker push rzippo/texlive-full:$tag;
docker push rzippo/texlive-full:latest;
