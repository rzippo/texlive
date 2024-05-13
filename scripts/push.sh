#!/bin/sh

# requires docker login beforehand

docker push rzippo/texlive-basic:may-2024;
docker push rzippo/texlive-basic:latest;

docker push rzippo/texlive-small:may-2024;
docker push rzippo/texlive-small:latest;

docker push rzippo/texlive-medium:may-2024;
docker push rzippo/texlive-medium:latest;

docker push rzippo/texlive-full:may-2024;
docker push rzippo/texlive-full:latest;
