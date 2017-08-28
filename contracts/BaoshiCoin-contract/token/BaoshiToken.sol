pragma solidity ^0.4.11;

import './StandardToken.sol';
contract BaoshiToken is StandardToken{
    string public name = "Baoshi Token";
    string public symbol = "BSC";
    uint public decimals = 18;
    
    address public founder = 0x0;

    uint256 public buyPrice = 0;
    
    
    event Buy(address indexed sender, uint useWei, uint bst);


    function BaoshiToken(address founderInput, uint256 totalSupplyInput, uint buyPriceInput) {
        founder = founderInput;
        totalSupply = totalSupplyInput;
        balances[this] = totalSupplyInput;
        buyPrice = buyPriceInput;
    }


    function buy() payable{
        uint256 tokens = msg.value.mul(buyPrice).div(1 ether);
        if(balances[this] < tokens) revert();
        balances[msg.sender] = balances[msg.sender].add(tokens);
        balances[this] = balances[this].sub(tokens);
        Buy(msg.sender, msg.value, tokens);
    }


    function() payable{
        uint256 tokens = msg.value.mul(buyPrice).div(1 ether);
        if(balances[this] < tokens) revert();
        balances[msg.sender] = balances[msg.sender].add(tokens);
        balances[this] = balances[this].sub(tokens);
        Buy(msg.sender, msg.value, tokens);
    }
}