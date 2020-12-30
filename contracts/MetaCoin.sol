// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import "./ConvertLib.sol";

function MetaCoin() public {
    balances[tx.origin] = 10000;
}

contract MetaCoin {
    mapping (address => uint) balances;

    address creator;

    uint creatorFee = 1;
    uint collectedFees = 0;
    uint conversionRate = 5;
    uint CURRENCY_MULTIPLIER = 10**18;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

     function MetaCoin() public {
        creator = msg.sender;
    }

    modifier onlyCreator() {
        if(msg.sender == creator || tx.origin == creator)
        {
            _;
        }
    }

    function collectFees() public onlyCreator {
        creator.transfer(collectedFees);
        collectedFees = 0;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value * conversionRate * CURRENCY_MULTIPLIER;
    }

    function withdraw(uint amount) public {
        amount = amount * CURRENCY_MULTIPLIER;

        balances[msg.sender] -= amount;
        msg.sender.transfer(amount / conversionRate);
    }


  
}
