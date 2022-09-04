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

    Vester vester;
    VestingCreator vestingCreator;

    function setUp() public {
        // Deploy transferrable Vester.
        // Set czar as MORPHO_DAO and gem to MORPHO_TOKEN.
        vm.startPrank(MORPHO_DAO);
        vester = new Vester(MORPHO_DAO, MORPHO_TOKEN);
        console.log("Vester address: ", address(vester));

        vestingCreator = new VestingCreator(address(vester));
        vm.stopPrank();
    }

    function testFailNotApproved() public {
        vm.prank(vm.addr(1));
        MECT_SWAP_APPROVER.setApproval(true);

        vm.prank(MORPHO_DAO);
        vestingCreator.createVesting(vm.addr(1), 1, MORPHO_LABS, true);
    }

    function testCreateVesting() public {
        vm.prank(MORPHO_DAO);
        vester.rely(address(vestingCreator));

        for (uint256 i; i < 10; ++i) {
            address user = vm.addr(i + 1);
            vm.prank(user);
            MECT_SWAP_APPROVER.setApproval(true);

            vm.prank(MORPHO_DAO);
            uint256 id = vestingCreator.createVesting(user, 1, MORPHO_LABS, true);
            console.log("id: ", id);

            assertEq(vester.usr(id), user, "usr");
            assertEq(vester.bgn(id), vestingCreator.BEGINNING(), "bgn");
            assertEq(vester.clf(id), vestingCreator.BEGINNING() + vestingCreator.CLIFF(), "clf");
            assertEq(vester.fin(id), vestingCreator.BEGINNING() + vestingCreator.DURATION(), "fin");
            assertEq(vester.mgr(id), MORPHO_LABS, "mgr");
            assertEq(vester.res(id), 0, "res");
            assertEq(vester.tot(id), 1, "tot");
            assertEq(vester.rxd(id), 0, "rxd");
            assertEq(vester.bls(id), 1, "bls");
        }
    }
}
