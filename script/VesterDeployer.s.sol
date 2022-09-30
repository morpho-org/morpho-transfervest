// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {Vester} from "src/Vester.sol";

contract VesterDeployer is Script {
    address public constant MORPHO_DAO = 0xcBa28b38103307Ec8dA98377ffF9816C164f9AFa;
    address public constant MORPHO_TOKEN = 0x9994E35Db50125E0DF82e4c2dde62496CE330999;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        Vester vester = new Vester(MORPHO_DAO, MORPHO_TOKEN);
        console.log(address(vester));
        vm.stopBroadcast();
    }
}
