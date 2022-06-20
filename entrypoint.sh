#!/bin/sh

MONIKER="${MONIKER:=${HOSTNAME}}"
PRUNING="${PRUNING:=nothing}"
ZT_NETWORK="${ZT_NETWORK:=159924d630338c1b}"

set -e

zerotier-one -d
sleep 1
zerotier-cli join $ZT_NETWORK
zerotier-cli listnetworks

if [ "$1" = 'shareledger' ]; then
  if [ -z "$(ls -A /shareledger)" ]; then
    shareledger init $MONIKER --home /shareledger
    curl -LJ https://github.com/ShareRing/Shareledger/releases/download/v1.2.0/genesis.json > /shareledger/config/genesis.json
  fi
  if [ -z "$2" ]; then
    shareledger start --pruning $PRUNING --home /shareledger --p2p.seeds 1877cddbd4f1e5c6d1d33106667a69ec31eeb281@192.168.194.50:26656,f42ed8ada782a66d89d4f12784990b562f78376a@192.168.194.75:26656,6f9ac0fd8f3341fe2342c378d8d31b1291db1661@192.168.194.22:26656,02d3c76619687479d3d038d96fe36a472bd834f9@192.168.194.64:26656,b916ca079551cc638149123a1621f98b113090e7@192.168.194.230:26656,f3018717656d99d66d5a38b62fee2d5cb1663fbf@192.168.194.232:26656,183748b5ff4c2e8fa7a832ac5ffe2e662b7052f1@192.168.194.231:26656,d15a915ebe511516a7b3fe324b9efd12af0d5550@192.168.194.185:26656,45bece57c460890aac44ee6e70c3f745fe019dc6@192.168.194.136:26656,717741f841dd22370b772a05ab26362b07b4f16c@192.168.194.101:26656,1b0a92dc461a5c5a3e6294c22e17fc30da08c16a@192.168.194.53:26656,69fd2d16de0c0b07a4be36838d7678c6734ace8c@192.168.194.109:26656
  fi
fi

exec "$@"
