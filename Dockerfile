FROM golang:1.12 AS build

WORKDIR /app
COPY ./go-libp2p-daemon/ .
RUN cd p2pd && go build .


FROM docker.io/python:3-slim-stretch

RUN apt-get update && apt-get install -y \
	procps \
	net-tools \
	iproute2 \
	tcpdump \
	traceroute \
	inetutils-ping \
	netcat \
	supervisor

#COPY ./go-libp2p-daemon/p2pd/p2pd /usr/bin/
COPY --from=0 /app/p2pd/p2pd /usr/bin
COPY ./meshsim/topologiser /topologiser

RUN pip3 install -r /topologiser/requirements.txt

COPY ./meshsim-node-p2pd/docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./meshsim-node-p2pd/docker/start.sh /

ENTRYPOINT ["/start.sh"]

