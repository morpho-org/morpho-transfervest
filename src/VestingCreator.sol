// SPDX-License-Identifier: GNU AGPLv3
pragma solidity 0.8.16;

import "./Vester.sol";

interface IMectSwapApprover {
    function approvals(address) external returns (bool);

    function setApproval(bool _approval) external;
}

contract VestingCreator {
    bool public constant RES = false;
    uint256 public constant CLIFF = 0;
    uint256 public constant BEGINNING = 1671886800;
    uint256 public constant DURATION = 77760000;
    address public constant MORPHO_DAO = 0xcBa28b38103307Ec8dA98377ffF9816C164f9AFa;
    IMectSwapApprover public constant MECT_SWAP_APPROVER = IMectSwapApprover(0x6327d36F66Fec925FadD387153eCE94d109f3D66);

    Vester public immutable VESTER;

    modifier onlyDAO() {
        require(msg.sender == MORPHO_DAO);
        _;
    }

    constructor(address _vester) {
        VESTER = Vester(_vester);
    }

    function createVesting(address _usr, uint256 _tot, address _mgr, bool _bls) external onlyDAO returns (uint256) {
        if (MECT_SWAP_APPROVER.approvals(_usr)) {
            return VESTER.create_custom(_usr, _tot, BEGINNING, DURATION, CLIFF, _mgr, RES, _bls);
        } else {
            return type(uint256).max;
        }
    }
}
