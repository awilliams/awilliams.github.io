FROM ubuntu:20.04

ARG WKHTMLTOPDF_VERSION=0.12.6-1

RUN \
      apt-get update -y && \
      apt-get install -y wget gdebi-core && \
      wget \
        https://github.com/wkhtmltopdf/packaging/releases/download/${WKHTMLTOPDF_VERSION}/wkhtmltox_${WKHTMLTOPDF_VERSION}.focal_arm64.deb \
        -O /tmp/wkhtmltopdf.deb && \
      gdebi --non-interactive /tmp/wkhtmltopdf.deb && \
      apt-get clean
