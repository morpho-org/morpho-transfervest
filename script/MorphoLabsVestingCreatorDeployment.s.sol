// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import {VestingCreator} from "src/VestingCreator.sol";

contract AdmoVestingCreatorDeployment is Script {
    address public constant MORPHO_LABS_VESTER = 0xe206A8006669A0913D6D13A781580e7E65524407;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        VestingCreator vester = new VestingCreator(MORPHO_LABS_VESTER);
        vm.stopBroadcast();
        console.log(address(vester));
    }
}
