FROM debian:buster-slim

# culr (optional) for downloading/browsing stuff
# nano (required) buster-slim doesn't even have less. so I needed an editor to view/edit file (eg: /etc/hosts) 
# libdigest-sha-perl needed to execute carvel/install.sh
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	unzip \
	curl \
    nano \
    less \
	openssh-client \
	psmisc \
	net-tools \
    iputils-ping \
    libdigest-sha-perl \
	&& curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
	&& chmod +x /usr/local/bin/kubectl

RUN curl -o /usr/local/bin/jq -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
  	chmod +x /usr/local/bin/jq

ENV DOCKERVERSION=20.10.12
RUN curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
	&& tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
					-C /usr/local/bin docker/docker \
	&& rm docker-${DOCKERVERSION}.tgz


RUN curl -L https://carvel.dev/install.sh | bash


COPY binaries/tmc /usr/local/bin/
RUN chmod +x /usr/local/bin/tmc

COPY binaries/wizards/init.sh /usr/local/
RUN chmod +x /usr/local/init.sh

ENTRYPOINT [ "/usr/local/init.sh"]