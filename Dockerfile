FROM corelight/aws-sphinx
LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Heavyweight builder/publisher for documentation with python, perl, aws-cli, Sphinx and LaTeX"

# This dependency footprint is considerably large.

RUN apk update && \
    apk add -v \
      graphviz \
      perl \
      wget \
      xz && \
    rm /var/cache/apk/*

ENV PATH /opt/texlive/bin/x86_64-linux:$PATH
ADD texlive.profile /tmp

# eval is required at critical step because install-tl "succeeds with warnings"
# i.e., finishes with non-zero return code, unhelpfully

RUN cd /tmp && \
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  tar xzf install-tl-unx.tar.gz && \
  eval install-tl-*/install-tl --profile /tmp/texlive.profile && \
  tlmgr install \
    capt-of \
    cmap \
    collection-fontsrecommended \
    environ \
    eqparbox \
    etoolbox \
    fancybox \
    fancyvrb \
    float \
    framed \
    fvextra \
    ifplatform \
    lineno \
    mdwtools \
    minted \
    multirow \
    parskip \
    threeparttable \
    titlesec \
    trimspaces \
    upquote \
    wrapfig \
    xcolor \
    xstring && \
  rm -rf /tmp/*

# Other tlmgr packages of possible relevance:
    # babel-english \
    # comment \
    # fancyhdr \
    # fontawesome \
    # genmisc \
    # lastpage \
    # pgf \
    # units \
