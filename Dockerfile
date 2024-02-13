FROM alpine:latest
MAINTAINER John <admin@vps.la>

ENV FRP_VERSION 0.54.0
WORKDIR /

RUN set -xe && \
    apk add tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata


RUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; \
	elif [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; \
	elif [ "$(uname -m)" = "armv7" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armv7l" ]; then export PLATFORM=arm ; \
	elif [ "$(uname -m)" = "armhf" ]; then export PLATFORM=arm ; fi

RUN set -xe && \
	wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_${PLATFORM}.tar.gz

RUN set -xe && \
	tar xzf frp_${FRP_VERSION}_linux_${PLATFORM}.tar.gz && \
	cd frp_${FRP_VERSION}_linux_${PLATFORM} && \
	mkdir /frp && \
	mv frpc frpc.ini /frp && \
	cd .. && \
	rm -rf *.tar.gz frp_${FRP_VERSION}_linux_${PLATFORM}

VOLUME /frp

CMD /frp/frpc -c /frp/frpc.ini
