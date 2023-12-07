FROM rockylinux:9

LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Heavyweight documentation-builder with python, perl, Sphinx and LaTeX"

ENV PATH /opt/texlive/bin/x86_64-linux:$PATH
ADD texlive.profile /tmp

# This dependency footprint is considerably large.

RUN yum update -y && \
    yum install -y \
      gcc \
      git \
# git required by Sphinx, oddly
      graphviz \
      make \
      perl \
      perl-Digest-MD5 \
      python3 \
      python3-pip \
      wget \
      xz && \
    echo -e "[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub" > /etc/yum.repos.d/google-chrome.repo && \
    dnf -y install google-chrome-stable && \
    pip3 install -U \
      alabaster==0.7.12 \
      Babel==2.12.1 \
      colorama==0.3.3 \
      daemonize==2.3.1 \
      docutils==0.19 \
      imagesize==1.4.1 \
      Jinja2==3.1.2 \
      jmespath==0.7.1 \
      MarkupSafe==2.1.2 \
      passlib==1.6.5 \
      pyasn1==0.1.8 \
      Pygments==2.15.0 \
      PyLaTeX==1.4.2 \
      pyslack==0.3.0 \
      python-dateutil==2.4.2 \
      python-gitlab==2.2.0 \
      pytz==2019.3 \
      pyyaml==3.12 \
      requests==2.28.2 \
      rsa==3.4.2 \
      six==1.13.0 \
      snowballstemmer==2.0.0 \
      sphinxemoji==0.1.4 \
      sphinx-better-theme==0.1.5 \
      sphinx-copybutton==0.5.0 \
      sphinx_design==0.5.0 \
      sphinx-design-elements==0.2.1 \
      sphinx-material==0.0.35 \
      sphinx-rtd-theme==0.1.9 \
      Sphinx==7.1.2 && \
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
      bbding \
      bitset \
      booktabs \
      capt-of \
      cmap \
      catchfile \
      changepage \
      collection-fontsrecommended \
      colortbl \
      ellipse \
      environ \
      eqparbox \
      etoolbox \
      fancybox \
      fncychap \
      fancyvrb \
      float \
      fontawesome \
      framed \
      fvextra \
      ifplatform \
      latexmk \
      letltxmacro \
      lineno \
      mdwtools \
      minted \
      multirow \
      needspace \
      opensans \
      parskip \
      pdfescape \
      pict2e \
      setspace \
      tabulary \
      threeparttable \
      titlesec \
      trimspaces \
      upquote \
      varwidth \
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
# Cannot extend corelight/aws-sphinx because texlive compiles *unworking* binaries on Alpine.
