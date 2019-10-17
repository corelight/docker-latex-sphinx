FROM corelight/aws-sphinx
LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Builder/publisher for documentation with aws-cli, Sphinx and LaTeX"

# This dependency footprint is considerably large.

RUN apk update && \
    apk add -v \
      graphviz \
      perl \
      texlive-full && \
    rm /var/cache/apk/*

#    perl-cpan |
# cpan App::cpanminus
#   apk add -v wget && \
#   wget -O /tmp/install-tl.zip http://mirrors.ctan.org/systems/texlive/tlnet/install-tl.zip && \
#   cd /tmp && \
#   unzip install-tl.zip && \
#   cd install-tl-20* && \
#   echo | cpan install TeXLive::TLPDB && \
#   rm -rf /tmp/*
#
# RUN tlmgr init-usertree
#
# RUN tlmgr install \
#       xcolor \
#       pgf \
#       fancyhdr \
#       parskip \
#       babel-english \
#       units \
#       lastpage \
#       mdwtools \
#       comment \
#       genmisc \
#       fontawesome
#
