contract Share {

    function shareTotal() constant returns (uint256 shareTotal) {}

    function shareBalanceOf(address _owner) constant returns (uint256 balance) {}


    function shareTransfer(address _to, uint256 _value) returns (bool success) {}


    function shareTransferFrom(address _from, address _to, uint256 _value) returns (bool success) {}


    function shareApprove(address _spender, uint256 _value) returns (bool success) {}


    function shareAllowance(address _owner, address _spender) constant returns (uint256 remaining) {}

    event ShareTransfer(address indexed _from, address indexed _to, uint256 _value);
    
    event ShareApproval(address indexed _owner, address indexed _spender, uint256 _value);

}