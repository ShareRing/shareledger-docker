# ShareLedger Docker

This helps running Shareledger full node in docker.

## Build

```
docker build -t shareledger-fullnode:v1.2.0 .
```

## Configuration

There are some environment variables:

- `MONIKER`: The node name. Shareledger needs to distinguish individual nodes from one another.
- `PRUNING`: Pruning mode. Possible values: default | nothing | everything | custom. With custom some other parameters need to be configured in `app.toml`
- `ZT_NETWORK`: The zerotier network to connect to. Defaults to 159924d630338c1b.

The environment variables can be set in various ways.

## Run

### By docker

```
docker run --rm --name shareledger-fullnode-01 --cap-add=NET_ADMIN --cap-add=SYS_ADMIN --device=/dev/net/tun --env MONIKER=node1 --env PRUNING=nothing --env ZT_NETWORK=159924d630338c1b shareledger-fullnode:v1.2.0 
```

Note: The `--rm` flag will remove the container when terminated. This is optional.

Also worth using volume mounting to mount the home dir /shareledger

```
docker run ...<as above>... -v $(pwd)/shareledger:/shareleder shareledger-fullnode:v1.2.0 
```

### By docker compose

Refers to `docker-compose.yml` for configuration.

```
docker compose up -d
```

## Notes:

Cap `NET_ADMIN`, `SYS_ADMIN` and device `/dev/net/tun` are required to run zerotier.

For existing nodes, please make sure to backup the home dir (`/shareledger`) first, then copy over some configuration and key files as guided in this: https://github.com/ShareRing/Shareledger/releases/download/v1.2.0/hard_fork_v1.2.0.sh

- oldshareledger/config/node_key.json
- oldshareledger/config/priv_validator_key.json
- oldshareledger/*.* (os keyring)
- oldshareledger/keyring-* (file keyring)