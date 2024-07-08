#!/bin/sh
tag=$(cat ../CURRENT_TAG)

docker buildx imagetools create -t rzippo/texlive-basic:$tag rzippo/texlive-basic-arm64:$tag rzippo/texlive-basic-amd64:$tag;
docker buildx imagetools create -t rzippo/texlive-basic:latest rzippo/texlive-basic-arm64:latest rzippo/texlive-basic-amd64:latest;

docker buildx imagetools create -t rzippo/texlive-small:$tag rzippo/texlive-small-arm64:$tag rzippo/texlive-small-amd64:$tag;
docker buildx imagetools create -t rzippo/texlive-small:latest rzippo/texlive-small-arm64:latest rzippo/texlive-small-amd64:latest;

docker buildx imagetools create -t rzippo/texlive-medium:$tag rzippo/texlive-medium-arm64:$tag rzippo/texlive-medium-amd64:$tag;
docker buildx imagetools create -t rzippo/texlive-medium:latest rzippo/texlive-medium-arm64:latest rzippo/texlive-medium-amd64:latest;

docker buildx imagetools create -t rzippo/texlive-full:$tag rzippo/texlive-full-arm64:$tag rzippo/texlive-full-amd64:$tag;
docker buildx imagetools create -t rzippo/texlive-full:latest rzippo/texlive-full-arm64:latest rzippo/texlive-full-amd64:latest;
