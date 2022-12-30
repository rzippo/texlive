FROM debian:bullseye
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=dumb

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ARG BUILD_DATE

# Fix for update-alternatives: error: error creating symbolic link '/usr/share/man/man1/rmid.1.gz.dpkg-tmp': No such file or directory
# See https://github.com/debuerreotype/docker-debian-artifacts/issues/24#issuecomment-360870939
RUN mkdir -p /usr/share/man/man1

# we additionally need python, java (because of pax), perl (because of pax), pdftk, ghostscript, and unzip (because of pax)
RUN apt-get update -qq && apt-get upgrade -qq && \
    # proposal by https://github.com/sumandoc/TeXLive-2017
    apt-get install -y wget curl libgetopt-long-descriptive-perl libdigest-perl-md5-perl fontconfig && \
    # libfile-copy-recursive-perl is required by ctanify
    apt-get install -y --no-install-recommends openjdk-11-jre-headless libfile-which-perl libfile-copy-recursive-perl pdftk ghostscript unzip openssh-client git && \
    apt-get install -y ruby poppler-utils && \
    # for plantuml, we need graphviz and inkscape. For inkscape, there is no non-X11 version, so 200 MB more
    apt-get install -y --no-install-recommends graphviz inkscape && \
    # add support for pygments
    apt-get install -y python3-pygments python3-pip zlib1g && \
    # fig2dev - tool for xfig to translate the figure to other formats
    apt-get install -y fig2dev && \
    # pandoc - to convert to latex
    apt-get install -y pandoc pandoc-citeproc && \
    # add Google's Inconsolata font (https://fonts.google.com/specimen/Inconsolata)
    apt-get install -y fonts-inconsolata && \
    # required to install IBMPlexMono font
    apt-get install -y fontconfig && \
    # required by tlmgr init-usertree
    apt-get install -y xzdec && \
    # required by drawio
    apt-get install -y libnotify4 libxss1 libnss3 libgbm1 libappindicator3-1 libsecret-1-0 libasound2 xdg-utils xvfb && \
    # save some space
    rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /home

ADD ./texlive.profile texlive.profile

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir install-tl && tar xf install-tl-unx.tar.gz -C install-tl --strip-components 1 && \ 
    cd install-tl && \
    ./install-tl -profile=../texlive.profile

ENV MANPATH="/usr/local/texlive/2022/texmf-dist/doc/man:${MANPATH}"
ENV INFOPATH="/usr/local/texlive/2022/texmf-dist/doc/info:${INFOPATH}"
ENV PATH="/usr/local/texlive/2022/bin/x86_64-linux:${PATH}"

# update texlive
# works if no new major release of texlive was done
#
# source: https://askubuntu.com/a/485945
RUN tlmgr init-usertree
RUN tlmgr info --only-installed
RUN tlmgr update --self --all --reinstall-forcibly-removed

# install IBM Plex fonts
RUN mkdir -p /tmp/fonts && \
    cd /tmp/fonts && \
    wget https://github.com/IBM/plex/releases/download/v2.0.0/OpenType.zip -q && \
    unzip OpenType.zip -x */LICENSE.txt */license.txt */CHANGELOG */.DS_Store && \
    cp -r OpenType/* /usr/local/share/fonts && \
    fc-cache -f -v

# update font index
RUN luaotfload-tool --update

# pandoc in the repositories is older - we just overwrite it with a more recent version
RUN wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-1-amd64.deb -q --output-document=/home/pandoc.deb && dpkg -i pandoc.deb && rm pandoc.deb

# get PlantUML in place
RUN wget https://netcologne.dl.sourceforge.net/project/plantuml/plantuml.jar -q --output-document=/home/plantuml.jar
ENV PLANTUML_JAR=/home/plantuml.jar

# install Ruby's bundler
RUN gem install bundler

# enable using the scripts of https://github.com/gi-ev/LNI-proceedings
RUN pip3 install pyparsing && pip3 install docx

# prepare usage of pax
RUN mkdir /root/.texlive2022 && perl `kpsewhich -var-value TEXMFDIST`/scripts/pax/pdfannotextractor.pl --install

# install pkgcheck
RUN wget https://gitlab.com/Lotz/pkgcheck/raw/master/bin/pkgcheck -q --output-document=/usr/local/bin/pkgcheck && chmod a+x /usr/local/bin/pkgcheck

# install drawio

ARG drawio_ver="20.7.4"

RUN curl -LO https://github.com/jgraph/drawio-desktop/releases/download/v$drawio_ver/draw.io-amd64-$drawio_ver.deb && \
    dpkg -i draw.io-amd64-$drawio_ver.deb && \
    rm draw.io-amd64-$drawio_ver.deb

RUN chmod +4755 /opt/draw.io/chrome-sandbox

RUN echo "#!/bin/sh\nxvfb-run /usr/bin/drawio \"\${@}\"" > /usr/local/bin/drawio && \
    chmod +x /usr/local/bin/drawio