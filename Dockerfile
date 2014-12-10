FROM ubuntu:14.10
MAINTAINER Jeremy Derr <jeremy@derr.me>

COPY ./bootstrap.sh /
RUN /bootstrap.sh
ENTRYPOINT ["/usr/bin/zsh"]
