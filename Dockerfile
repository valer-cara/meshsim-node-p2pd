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

RUN pip install \
		flask \
		requests \
		psycopg2-binary

COPY ./go-libp2p-daemon/p2pd/p2pd /usr/bin/
COPY ./meshsim/topologiser /topologiser

COPY ./meshsim-node-p2pd/docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY ./meshsim-node-p2pd/docker/start.sh /

ENTRYPOINT ["/start.sh"]

