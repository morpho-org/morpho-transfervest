#!/bin/bash

# fail immediately if a command fails
set -eo pipefail

if [[ -z ${1} ]]; then
	echo "First argument (owner) not found, please set it and re-run the last command."
	exit 1
fi
OWNER=$1

forge script script/VesterDeployer.s.sol:VesterDeployer --rpc-url http://127.0.0.1:8545 --sender "$OWNER"
