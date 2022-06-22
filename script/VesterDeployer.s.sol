// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {Vester} from "src/Vester.sol";

contract VesterDeployer is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Vester vester = new Vester(msg.sender, address(1));
        console.log(address(vester));
        vm.stopBroadcast();
    }
}
