// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {Vester} from "src/Vester.sol";

contract VesterScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new Vester(address(msg.sender),address(0));
    }
}
