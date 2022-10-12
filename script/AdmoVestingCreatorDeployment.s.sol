// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {VestingCreator} from "src/VestingCreator.sol";

contract AdmoVestingCreatorDeployment is Script {
    address public constant ADMO_VESTER = 0x60167C23eECe006dF7aDB048AeC4b4558957eB5A;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        VestingCreator vester = new VestingCreator(ADMO_VESTER);
        vm.stopBroadcast();
        console.log(address(vester));
    }
}
