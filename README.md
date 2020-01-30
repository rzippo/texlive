### Docker image for texlive

`docker pull rzippo/texlive`

Based on [danteev/texlive](https://github.com/dante-ev/docker-texlive), but the texlive distribution is installed via [`install-tl`](https://www.tug.org/texlive/quickinstall.html) script rather than apt package, in order to have the most recent version for each package.