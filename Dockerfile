FROM ubuntu:20.04

# ARG MONIKER

WORKDIR /shareledger

COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

# RUN apk update && apk upgrade && apk add bash curl libc6-compat
RUN apt-get update && apt-get install -y gnupg curl

RUN curl -s https://install.zerotier.com | bash

# RUN ufw default deny && \
#     ufw limit ssh/tcp && \
#     ufw limit ssh comment 'Rate limit for openssh server' && \
#     ufw allow in on ztyourowrl to any port 46656 && \
#     ufw allow in on ztyourowrl to any port 46657 && \
#     ufw allow in on ztyourowrl to any port 26656 && \
#     ufw allow in on ztyourowrl to any port 26657 && \
#     ufw allow 9993/udp && \
#     echo "y" | ufw enable

RUN curl -LJ https://github.com/ShareRing/Shareledger/releases/download/v1.2.0/shareledger > /usr/bin/shareledger && \
    chmod +x /usr/bin/shareledger

# RUN shareledger init $MONIKER --home /shareledger

# RUN curl -LJ https://github.com/ShareRing/Shareledger/releases/download/v1.2.0/genesis.json > /shareledger/config/genesis.json

EXPOSE 26656 26657 26660 9090 1317

ENTRYPOINT ["/entrypoint.sh"]

CMD ["shareledger"]