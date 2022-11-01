// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {Vester} from "src/Vester.sol";

contract MorphoLabsVesterDeployment is Script {
    address public constant MORPHO_LABS = 0x1590e7F4c3E1B4493Abb462e34593aef3A9397Dd;
    address public constant MORPHO_TOKEN = 0x9994E35Db50125E0DF82e4c2dde62496CE330999;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Vester vester = new Vester(MORPHO_LABS, MORPHO_TOKEN);
        vm.stopBroadcast();
        console.log(address(vester));
    }
}
