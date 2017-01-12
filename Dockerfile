#
#
#

# Pull base image.
FROM ubuntu:14.04
# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y software-properties-common&& \
  add-apt-repository ppa:monatr/monacoin && \
  apt-get update && \
  apt-get install -y monacoind && \
  apt-get install -y supervisor &&\
  apt-get autoremove -y software-properties-common&& \
  apt-get -y upgrade
# Add files.
ADD root/etc/supervisor/conf.d/monacoind.conf /etc/supervisor/conf.d/monacoind.conf 
# Set environment variables.
ENV HOME /root
# Define working directory.
WORKDIR /root
# Volume for Wallet
VOLUME ["/wallet"]
# Port: RPC = 9402, P2P = 9401
EXPOSE 9401 9402
# Define default command.
CMD ["/usr/bin/supervisord"]
