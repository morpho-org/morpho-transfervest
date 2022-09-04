// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import {VestingCreator, IMectSwapApprover} from "src/VestingCreator.sol";
import {Vester} from "src/Vester.sol";

contract VestingCreatorTest is Test {
    address constant MORPHO_TOKEN = 0x9994E35Db50125E0DF82e4c2dde62496CE330999;
    IMectSwapApprover constant MECT_SWAP_APPROVER = IMectSwapApprover(0x6327d36F66Fec925FadD387153eCE94d109f3D66);
    address constant MORPHO_DAO = 0xcBa28b38103307Ec8dA98377ffF9816C164f9AFa;
    address constant MORPHO_LABS = 0x1590e7F4c3E1B4493Abb462e34593aef3A9397Dd;
    address constant ADMO = 0x6ABfd6139c7C3CC270ee2Ce132E309F59cAaF6a2;

    function setUp() public {}

    function testVestingCreator() public {
        // Deploy transferrable Vester.
        // Set czar as MORPHO_DAO and gem to MORPHO_TOKEN.
        vm.startPrank(MORPHO_DAO);
        Vester vester = new Vester(MORPHO_DAO, MORPHO_TOKEN);
        console.log("Vester address: ", address(vester));

        VestingCreator vestingCreator = new VestingCreator(address(vester));
        vester.rely(address(vestingCreator));
        vm.stopPrank();

        for (uint256 i; i < 10; ++i) {
            address user = vm.addr(i + 1);
            vm.prank(user);
            MECT_SWAP_APPROVER.setApproval(true);

            vm.prank(MORPHO_DAO);
            uint256 id = vestingCreator.createVesting(user, 1, MORPHO_LABS, true);
            console.log("id: ", id);
        }
    }
}
