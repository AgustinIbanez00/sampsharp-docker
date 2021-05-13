FROM ubuntu:18.04

RUN dpkg --add-architecture i386

RUN apt-get update && apt-get install -y \
 lib32stdc++6 \
 libicu-dev:i386 \
 wget \
 procps \
 unzip

RUN wget http://files.sa-mp.com/samp037svr_R2-2-1.tar.gz \
 && tar xzf samp037svr_R2-2-1.tar.gz \
 && rm -f samp037svr_R2-2-1.tar.gz \
 && mv /samp03 /samp-svr \
 && cd samp-svr \
 && rm -rf include npcmodes/*.pwn filterscripts/*.pwn gamemodes/*.pwn \
 && mv samp03svr samp-svr \
 && chmod 700 *

RUN wget https://github.com/ikkentim/SampSharp/releases/download/0.9.3/SampSharp-0.9.3.zip \
 && unzip SampSharp-0.9.3.zip \
 && rm -f SampSharp-0.9.3.zip \
 && cp -r /SampSharp-0.9.3/* /samp-svr \
 && cd /samp-svr \
 && mkdir files && cd /samp-svr\
 && rm -rf include npcmodes/*.pwn filterscripts/*.pwn gamemodes/*.pwn \
 && chmod 700 * \
 && rm -f -R /SampSharp-0.9.3

COPY samp.sh /usr/local/bin/samp
COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x /usr/local/bin/samp \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["samp", "start"]

EXPOSE 7777/udp
