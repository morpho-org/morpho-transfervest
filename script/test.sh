#!/bin/bash

set -o allexport; source .env; set +o allexport

forge test -vvv --fork-url https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_KEY} > trace.ansi