import "./StandShare.sol";
import "../util/SafeMath.sol";
import "../token/BaoshiTokenV1.sol";
contract GameShare{
    //about share allocation
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

    BaoshiTokenV1 public baoShiContract;
    
    function setGameShareOwner(address _owner){
        shareOwner = _owner;
        baoShiContract = BaoshiTokenV1(centerAddress);
    }
    
    function startCrowd(){
        if(msg.sender != shareOwner) revert();
        canCrowdFlag = true;
    }
    
    function stopCrowd(){
        if(msg.sender != shareOwner) revert();
        canCrowdFlag = false;
    }


    function setShare(uint256 shareForRewardInput, uint256 shareForCrowdInput, uint256 shareForOwnerInput, uint256 totalShareInput, uint256 sharePriceInput){
        if(msg.sender != shareOwner) revert();
        if(sharedFlag == true) revert();
        if(shareForRewardInput+shareForCrowdInput+shareForCrowdInput != totalShareInput) revert();
        shareForReward = shareForRewardInput;
        shareForCrowd = shareForCrowdInput;
        shareForOwner = shareForOwnerInput;
        totalShare = totalShareInput;
        sharePrice = sharePriceInput;
        shareBalances[shareOwner] = totalShareInput;
        shareApprove(centerAddress,shareForReward);
    }

    
    function buyShareByCorwd(uint bsCoinValueInput){
        if(canCrowdFlag == false) revert();
        if(baoShiContract.balanceOf(msg.sender) < bsCoinValueInput) revert();
        if(bsCoinValueInput > shareForReward) revert();
        uint buyNum = safeMul(sharePrice,bsCoinValueInput);
        if((shareBalances[msg.sender] + buyNum) <= shareBalances[msg.sender]) revert();
        baoShiContract.transferFrom(msg.sender, shareOwner, bsCoinValueInput);
        shareBalances[msg.sender] = safeAdd(shareBalances[msg.sender],buyNum);
        shareBalances[shareOwner] = safeSub(shareBalances[shareOwner],buyNum);
        shareForReward = safeSub(shareForReward, buyNum);
    }
}