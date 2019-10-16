FROM corelight/aws-sphinx
LABEL maintainer="Corelight AWS Team <aws@corelight.com>"
LABEL description="Builder/publisher for documentation with aws-cli, Sphinx and LaTeX"

RUN apk update && \
    apk add -v \
      perl \
      texlive \
    && rm /var/cache/apk/*
