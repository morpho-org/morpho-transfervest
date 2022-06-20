#!/bin/bash


# fail immediately if a command fails
set -eo pipefail

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

# From DssVest.sol
# @param _usr The recipient of the reward
# @param _tot The total amount of the vest
# @param _bgn The starting timestamp of the vest
# @param _tau The duration of the vest (in seconds)
# @param _eta The cliff duration in seconds (i.e. 1 years)
# @param _mgr An optional manager for the contract. Can yank if vesting ends prematurely.
# @param _res Whether the vesting can be claimed by the usr only
# @param _hly Whether the vesting is uninterruptible
SIG="create_custom(address,uint256,uint256,uint256,uint256,address,bool,bool)"x

echo "Vester" "$VESTER"
echo "Signer" "$SIGNER"

echo "Arguments:"
echo "Recipient      (usr) $RECIPIENT"
echo "Total reward   (tot) $TOTAL ($SIMPLE_TOTAL tokens)"
echo "Start ts       (bgn) $START"
echo "Vest duration  (tau) $DURATION"
echo "Cliff duration (eta) $CLIFF_DURATION"
echo "Manager        (mgr) $MANAGER"
echo "Restricted     (res) $RESTRICTED"
echo "Blessed        (bls) $BLESSED"
echo "Calldata:"

echo "Call result:"


cast call $VESTER $SIG $RECIPIENT $TOTAL $START $DURATION $CLIFF_DURATION $MANAGER $RESTRICTED $BLESSED --from SIGNER