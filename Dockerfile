FROM debian:bullseye
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=dumb

# avoid debconf and initrd
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

ARG BUILD_DATE

ARG USERNAME=texlive
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Fix for update-alternatives: error: error creating symbolic link '/usr/share/man/man1/rmid.1.gz.dpkg-tmp': No such file or directory
# See https://github.com/debuerreotype/docker-debian-artifacts/issues/24#issuecomment-360870939
RUN mkdir -p /usr/share/man/man1

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
    # required by tlmgr init-usertree
    apt-get install -y xzdec && \
    # required by drawio
    apt-get install -y libnotify4 libxss1 libnss3 libgbm1 libappindicator3-1 libsecret-1-0 libasound2 xdg-utils xvfb && \
    # save some space
    rm -rf /var/lib/apt/lists/* && apt-get clean

WORKDIR /home

ARG TEXLIVE_PROFILE=./profiles/texlive-small.profile

ADD ${TEXLIVE_PROFILE} texlive.profile

RUN wget https://mirrors.mit.edu/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir install-tl && tar xf install-tl-unx.tar.gz -C install-tl --strip-components 1 && \ 
    cd install-tl && \
    ./install-tl -profile=../texlive.profile

## cleanup
RUN rm -r ./install-tl && \
    rm ./install-tl-unx.tar.gz && \
    rm ./texlive.profile

ENV MANPATH="/usr/local/texlive/texmf-dist/doc/man:${MANPATH}"
ENV INFOPATH="/usr/local/texlive/texmf-dist/doc/info:${INFOPATH}"
ENV PATH="/usr/local/texlive/bin/x86_64-linux:${PATH}"

# update texlive
# works if no new major release of texlive was done
#
# source: https://askubuntu.com/a/485945
RUN tlmgr init-usertree
RUN tlmgr info --only-installed
RUN tlmgr update --self --all --reinstall-forcibly-removed

# install drawio

ARG drawio_ver="20.7.4"

RUN curl -LO https://github.com/jgraph/drawio-desktop/releases/download/v$drawio_ver/drawio-amd64-$drawio_ver.deb && \
    dpkg -i drawio-amd64-$drawio_ver.deb
    
## cleanup
RUN rm drawio-amd64-$drawio_ver.deb

RUN chmod +4755 /opt/drawio/chrome-sandbox

RUN echo "#!/bin/sh\nxvfb-run /usr/bin/drawio \"\${@}\"" > /usr/local/bin/drawio && \
    chmod +x /usr/local/bin/drawio

# Add powershell 7.4, using deb package
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.4.2/powershell_7.4.2-1.deb_amd64.deb && \
    dpkg -i powershell_7.4.2-1.deb_amd64.deb

## Cleanup
RUN rm powershell_7.4.2-1.deb_amd64.deb

# Set the default user as non-root
USER $USERNAME

RUN tlmgr init-usertree
