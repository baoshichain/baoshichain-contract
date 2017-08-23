import "./StandToken.sol";
import "../util/SafeMath.sol";
contract BaoshiTokenV1 is StandardToken, SafeMath {

    string public name = "Baoshi Token";
    string public symbol = "BSC";
    uint public decimals = 18;
    
    // Initial founder address (set in constructor)
    // All deposited ETH will be instantly forwarded to this address.
    // Address is a multisig wallet.              
    address public founder = 0x0;

    uint public buyPrice = 0;
    
    
    event Buy(address indexed sender, uint useWei, uint fbt);


    function BaoshiTokenV1(address founderInput, uint256 totalSupplyInput, uint buyPriceInput) {
        founder = founderInput;
        totalSupply = totalSupplyInput;
        balances[this] = totalSupplyInput;
        buyPrice = buyPriceInput;
    }


    function buy() payable{
        uint tokens = safeMul(msg.value,buyPrice)/1 ether;
        if(balances[this] < tokens) throw;
        balances[msg.sender] = safeAdd(balances[msg.sender], tokens);
        balances[this] = safeSub(balances[this],tokens);
        Buy(msg.sender, msg.value, tokens);
    }


    function transfer(address _to, uint256 _value) returns (bool success) {
        return super.transfer(_to, _value);
        
    }


    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        return super.transferFrom(_from, _to, _value);
    }


    function() payable{
        uint tokens = safeMul(msg.value,buyPrice)/1 ether;
        if(balances[this] < tokens) throw;
        balances[msg.sender] = safeAdd(balances[msg.sender], tokens);
        balances[this] = safeSub(balances[this],tokens);
        Buy(msg.sender, msg.value, tokens);

}