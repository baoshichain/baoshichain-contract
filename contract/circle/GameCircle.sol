import "../share/GameShare.sol";
contract GameCircle is GameShare{
     string public circleName;
     uint public circleType;
     uint256 public gamePrice = 9999999999;
     address public circleId;
     address public circleOwner;
     address public centerAddress;
     BaoshiTokenV1 public baoShiContract;
     mapping(address => uint) circleMembers;
     uint memberNumber = 0;
     bool canBuyGameFlag = false;
     
     function GameCircle(string circleNameInput, uint8 circleTypeInput, address circleOwnerInput){
        shareOwner = circleOwnerInput;
        baoShiContract = BaoshiTokenV1(centerAddress);
        circleName = circleNameInput;
        circleOwner = circleOwnerInput;
        circleType = 1;
        baoShiContract = BaoshiTokenV1(0xCcfEc6bC1e8eF095beA7d3142a8efd87EE571a9c);
        centerAddress = 0xCcfEc6bC1e8eF095beA7d3142a8efd87EE571a9c;
        circleId = this;
        memberNumber += 1;
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
         if(baoShiContract.balanceOf(msg.sender) < gamePrice) revert();
         baoShiContract.transferFrom(msg.sender, circleOwner, gamePrice);
     }
     
     function donate(uint bscValueInput){
         shareTransfer(shareOwner,bscValueInput);
     }
     
}
