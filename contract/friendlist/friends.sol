pragma solidity ^0.4.11;
contract mapTest{
    mapping(address => mapping(address=>uint8)) public friendsMap;
    mapping(address => mapping(address=>uint8)) public fansMap;
    mapping(address => address[]) public friendAddressArrays;
    mapping(address => address[]) public fansAddressArrays;
    
    event friendEvent(address addrFollow, address addrFollowed, uint8 value);
    event resultEvent(address[] resultAddressArray);
    
    function addFriend(address addrFollow, address addrFollowed){
        uint flagA = 0;
        uint flagB = 0;
        var followArray = friendAddressArrays[addrFollow];
        for(uint i=0; i<followArray.length; i++){
            if(followArray[i] == addrFollowed){
                flagA = 1;
                break;
            }
        }
        if(flagA == 0){
            friendAddressArrays[addrFollow].push(addrFollowed);
        }
        friendsMap[addrFollow][addrFollowed] = 1;
        
        var fansArray = fansAddressArrays[addrFollowed];
        for(uint j=0; j<fansArray.length; j++){
            if(fansArray[j] == addrFollow){
                flagB =1;
                break;
            }
        }
        if(flagB == 0){
            fansAddressArrays[addrFollowed].push(addrFollow);
        }
        fansMap[addrFollowed][addrFollow]=1;
        
        friendEvent(addrFollow,addrFollowed,1);
    }
    
    
    
    function cancelFriend(address addrFollow, address addrFollowed){
        uint flag = 0;
        friendsMap[addrFollow][addrFollowed] = 0;
        fansMap[addrFollowed][addrFollow]=0;
    }
    
    function FriendArray(address _address) returns (address[]){
        address[] memory resultArray;
        var followArray = friendAddressArrays[_address];
        for(uint i=0; i<followArray.length; i++){
            if(friendsMap[_address][followArray[i]] == 1){
                resultArray.push(followArray[i]);
            }
        }
        resultEvent(resultArray);
        return resultArray;
    }
    
    function FansArray(address _address) returns (address[]){
        address[] resultArray;
        var followedArray = fansAddressArrays[_address];
        for(uint i=0; i<followedArray.length; i++){
            if(fansMap[_address][followedArray[i]] == 1){
                resultArray.push(followedArray[i]);
            }
        }
        resultEvent(resultArray);
        return resultArray;
    }
    
    
    
    
}