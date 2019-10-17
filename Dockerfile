# Cannot extend corelight/aws-sphinx because texlive compiles *unworking* binaries on Alpine.
FROM centos:8

LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Heavyweight documentation-builder with python, perl, Sphinx and LaTeX"

ENV PATH /opt/texlive/bin/x86_64-linux:$PATH
ADD texlive.profile /tmp

# This dependency footprint is considerably large.

RUN yum update -y && \
    yum install -y \
      gcc \
      graphviz \
      make \
      perl \
      perl-Digest-MD5 \
      python3 \
      python3-pip \
      wget \
      xz && \
    pip3 install -U \
      alabaster==0.7.8 \
      Babel==2.3.4 \
      colorama==0.3.3 \
      daemonize==2.3.1 \
      docutils==0.12 \
      imagesize==0.7.1 \
      Jinja2==2.8 \
      jmespath==0.7.1 \
      MarkupSafe==0.23 \
      passlib==1.6.5 \
      pyasn1==0.1.8 \
      Pygments==2.1.3 \
      pyslack==0.3.0 \
      python-dateutil==2.4.2 \
      pytz==2016.6.1 \
      pyyaml==3.12 \
      requests==2.10.0 \
      rsa==3.4.2 \
      six==1.10.0 \
      snowballstemmer==1.2.1 \
      sphinx-better-theme==0.1.5 \
      sphinx-rtd-theme==0.1.9 \
      Sphinx==1.4.5 && \
    yum clean all

# Failover is required at critical step because install-tl "succeeds with warnings",
# i.e., finishes with non-zero return code, unhelpfully.

RUN cd /tmp && \
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  tar xzf install-tl-unx.tar.gz && \
  (install-tl-*/install-tl --profile /tmp/texlive.profile || echo "NOTE: install-tl exit value: $?") && \
  rm -rf /tmp/*

# SHELL ["/bin/bash", "-c"]

RUN tlmgr install \
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
      xstring

# Other tlmgr packages of possible relevance:
    # babel-english \
    # comment \
    # fancyhdr \
    # fontawesome \
    # genmisc \
    # lastpage \
    # pgf \
    # units \
