import "./Share.sol";
contract StandardShare is Share {

    /**
     * Reviewed:
     * - Interger overflow = OK, checked
     */
    function transfer(address _to, uint256 _value) returns (bool success) {
        //Default assumes totalSupply can't be over max (2^256 - 1).
        //If your token leaves out totalSupply and can issue more tokens as time goes on, you need to check if it doesn't wrap.
        //Replace the if with this one instead.
        if (shareBalances[msg.sender] >= _value && shareBalances[_to] + _value > shareBalances[_to]) {
        //if (balances[msg.sender] >= _value && _value > 0) {
            shareBalances[msg.sender] -= _value;
            shareBalances[_to] += _value;
            ShareTransfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function shareTransferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        //same as above. Replace this line with the following if you want to protect against wrapping uints.
        if (shareBalances[_from] >= _value && shareAllowed[_from][msg.sender] >= _value && shareBalances[_to] + _value > shareBalances[_to]) {
        //if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            shareBalances[_to] += _value;
            shareBalances[_from] -= _value;
            shareAllowed[_from][msg.sender] -= _value;
            ShareTransfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

    function shareBalanceOf(address _owner) constant returns (uint256 balance) {
        return shareBalances[_owner];
    }

    function shareApprove(address _spender, uint256 _value) returns (bool success) {
        shareAllowed[msg.sender][_spender] = _value;
        ShareApproval(msg.sender, _spender, _value);
        return true;
    }

    function shareAllowance(address _owner, address _spender) constant returns (uint256 remaining) {
      return shareAllowed[_owner][_spender];
    }

    mapping(address => uint256) shareBalances;

    mapping (address => mapping (address => uint256)) shareAllowed;



}
