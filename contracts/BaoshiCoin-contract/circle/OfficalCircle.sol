pragma solidity ^0.4.11;

import "../share/GameShare.sol";
import "./CircleBasic.sol";

contract OfficalCircle is GameShare,CircleBasic{
    //BaoshiToken public baoshiCoinContract;
     uint256 public gamePrice = 9999999999;
     bool canBuyGameFlag = false;

    function OfficalCircle(string circleNameInput, address circleOwnerInput){
        circleOwner = circleOwnerInput;
        baoShiTokenContract = BaoshiToken(centerAddress);
        circleName = circleNameInput;
        circleId = this;
        memberNumber = memberNumber.add(1);
        circleMembers[msg.sender] = memberNumber;
    }
     
    function canBuyGame(){
         if(msg.sender != circleOwner) revert();
         if(canBuyGameFlag == true) revert();
         canBuyGameFlag = true;
    }
     
    function stopBuyGame(){
         if(msg.sender != circleOwner) revert();
         if(canBuyGameFlag == false) revert();
         canBuyGameFlag = false;
    }
     
    function setGamePrice(uint256 priceInput){
         if(msg.sender != circleOwner) revert();
         gamePrice = priceInput;
    }
     
    function buyGame(){
         if(circleMembers[msg.sender] > 0) revert();
         if(baoShiTokenContract.balanceOf(msg.sender) < gamePrice) revert();
         baoShiTokenContract.transferFrom(msg.sender, circleOwner, gamePrice);
    }
     
    function donate(uint bscValueInput){
         baoShiTokenContract.transferFrom(msg.sender, circleOwner, bscValueInput);
    }
     
     
}