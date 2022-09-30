#!/bin/bash

# fail immediately if a command fails
set -eo pipefail

source .env

if [[ -z ${1} ]]; then
	echo "First argument (vester) not found, please set it and re-run the last command."
	exit 1
fi
VESTER=$1

if [[ -z ${2} ]]; then
	echo "Second argument (signer) not found, please set it and re-run the last command."
	exit 2
fi
SIGNER=$2

echo "Vester" "$VESTER"
echo "Signer" "$SIGNER"

echo "Clear csv file"
> vestings_calldata.csv

while IFS=, read -r recipient amount manager blessed; do

	echo "New Vesting"

	RECIPIENT=$recipient
	TOTAL=$amount
	MANAGER=$manager
	BLESSED=$blessed

	# From DssVest.sol
	# @param _usr The recipient of the reward
	# @param _tot The total amount of the vest
	# @param _mgr An optional manager for the contract. Can yank if vesting ends prematurely.
	# @param _bls Whether the vesting is uninterruptible
	SIG="createVesting(address,uint256,address,bool)"

	echo "Arguments:"
	echo "Recipient      (usr) $RECIPIENT"
	echo "Total reward   (tot) $TOTAL tokens"
	echo "Manager        (mgr) $MANAGER"
	echo "Blessed        (bls) $BLESSED"

	echo ""
	echo "Save calldata..."
	cast calldata $SIG $RECIPIENT $TOTAL $MANAGER $BLESSED --from $SIGNER >> vestings_calldata.csv
	echo "Saved"

	# echo ""
	# echo "Call result:"
	# cast call $VESTER $SIG $RECIPIENT $TOTAL $MANAGER $BLESSED --from $SIGNER

done < vesting_params_example.csv
