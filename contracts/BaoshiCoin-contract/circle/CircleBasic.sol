pragma solidity ^0.4.11;
contract CircleBasic{
     string public circleName;
     address public circleId;
     address public circleOwner;
     mapping(address => uint) circleMembers;
     uint memberNumber = 0;
}