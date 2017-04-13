FROM jfloff/alpine-python:2.7-slim 
MAINTAINER ider "326737833@qq.com"

ENV _XXNET_VERSION 3.3.0
WORKDIR /root/XX-Net-"$_XXNET_VERSION"
#ADD  "$_XXNET_VERSION" /root
ADD  https://codeload.github.com/XX-net/XX-Net/zip/"$_XXNET_VERSION" /root
RUN unzip -q -d /root /root/"$_XXNET_VERSION" \
	&& apk add --no-cache py-openssl \
 	&& sed -i "s/allow_remote_connect\"], 0/allow_remote_connect\"], 1/" \
		code/default/launcher/config.py \
	&& rm /root/"$_XXNET_VERSION"  
#RUN  sed -i "s/allow_remote_connect: 0/allow_remote_connect: 1/" \
#	data/launcher/config.yaml 
VOLUME /root/XX-Net-"$_XXNET_VERSION"/data/gae_proxy/
COPY manual.ini data/gae_proxy/manual.ini
EXPOSE 8087 8085
CMD ["/bin/bash","-c", "./start"]

