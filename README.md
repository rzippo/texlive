### Docker image for texlive

`docker pull rzippo/texlive-full`

The texlive distribution is installed via [`install-tl`](https://www.tug.org/texlive/quickinstall.html) script rather than apt package, in order to have the most recent version for each package.
Some packages are added for personal comfort and use:
- drawio
- powershell

Comes in four flavors, based on the number of tex packages included by default
- `texlive-full`
- `texlive-medium`
- `texlive-small`
- `texlive-basic`

In any case, you can add additional packages in your own Dockerfile

```dockerfile
FROM rzippo/texlive-basic

RUN tlmgr install \
    pgf \
    pgfplots \
    xcolor \
    preview
```

Originally based on [danteev/texlive](https://github.com/dante-ev/docker-texlive).