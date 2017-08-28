pragma solidity ^0.4.11;

import './StandardShare.sol';
import '../math/SafeMath.sol';
import '../token/BaoshiToken.sol';

contract GameShare is StandardShare{
    uint256 public totalShare;
    uint256 public shareForReward;
    uint256 public shareForCrowd;
    uint256 public shareForOwner;
    uint256 public sharePrice;
    address public shareOwner;
    bool public sharedFlag = false;
    bool public canCrowdFlag = false;
    bool public upGanmeflag = false;
    address public centerAddress = 0xCcfEc6bC1e8eF095beA7d3142a8efd87EE571a9c;
    address public gameShareId;
    uint256 public crowdDealine;
    mapping(address => uint) public withdrawBsc;
    
    address[] public shareHolderAdress;
    
    mapping(address => uint) public shareHolderId;    
    
    uint public shareHolderNumber = 0;

    BaoshiToken public baoShiTokenContract;
    
    
    function GameShare(){
        shareOwner = msg.sender;
        baoShiTokenContract = BaoshiToken(centerAddress);
        gameShareId = this;
    }
    
    
    function startCrowd(uint crowdMinutes){
        if(msg.sender != shareOwner) revert();
        crowdDealine = now.add(crowdMinutes).mul(1 minutes);
        canCrowdFlag = true;
    }
    
    function stopCrowd(){
        if(msg.sender != shareOwner) revert();
        canCrowdFlag = false;
    }


    function setShare(uint256 shareForRewardInput, uint256 shareForCrowdInput, uint256 shareForOwnerInput, uint256 totalShareInput, uint256 sharePriceInput){
        if(msg.sender != shareOwner) revert();
        if(sharedFlag == true) revert();
        if(shareForRewardInput+shareForCrowdInput+shareForOwnerInput != totalShareInput) revert();
        shareForReward = shareForRewardInput;
        shareForCrowd = shareForCrowdInput;
        shareForOwner = shareForOwnerInput;
        totalShare = totalShareInput;
       // totalShare = shareForRewardInput+shareForCrowdInput+shareForOwnerInput;
        sharePrice = sharePriceInput;
        balances[shareOwner] = totalShare;
        shareHolderAdress.push(0x0);
        shareHolderId[0x0] = 0;
        shareHolderNumber = shareHolderNumber.add(1);
        shareHolderId[shareOwner] = shareHolderNumber;
        shareHolderAdress.push(shareOwner);
        sharedFlag = true;
    }

    
    function buyShareByCorwd(uint256 bsCoinValueInput){
        if(canCrowdFlag == false) revert();
        if(now > crowdDealine) revert();
        if(baoShiTokenContract.balanceOf(msg.sender) < bsCoinValueInput) revert();
        uint256 buyNum = sharePrice.mul(bsCoinValueInput);
        if(buyNum > shareForReward) revert();
        if((balances[msg.sender].add(buyNum)) <= balances[msg.sender]) revert();
        if(allowance(shareOwner,this) < buyNum) revert();
        if(baoShiTokenContract.transferFrom(shareOwner, msg.sender, bsCoinValueInput)){
            if(shareHolderId[msg.sender] == 0){
                shareHolderNumber = shareHolderNumber.add(1);
                shareHolderId[msg.sender] = shareHolderNumber;
                shareHolderAdress.push(msg.sender);
            }
            balances[shareOwner] -= buyNum;
            balances[msg.sender] += buyNum;
            shareForReward -= buyNum;
        }
    }
}