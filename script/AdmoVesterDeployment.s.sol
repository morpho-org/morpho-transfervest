// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {Vester} from "src/Vester.sol";

contract AdmoVesterDeployment is Script {
    address public constant ADMO = 0x6ABfd6139c7C3CC270ee2Ce132E309F59cAaF6a2;
    address public constant MORPHO_TOKEN = 0x9994E35Db50125E0DF82e4c2dde62496CE330999;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Vester vester = new Vester(ADMO, MORPHO_TOKEN);
        vm.stopBroadcast();
        console.log(address(vester));
    }
}
