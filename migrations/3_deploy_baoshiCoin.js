var BaoshiToken = artifacts.require("./BaoshiToken.sol");
var GameShare = artifacts.require("./GameShare.sol");
var OfficalCircle = artifacts.require("./OfficalCircle.sol");

module.exports = function(deployer) {
  deployer.deploy(BaoshiToken,"0xe559eddf4367634912316d71d4f0b52766c64a79",100000000,10).then(function(){
  	deployer.deploy(GameShare,BaoshiToken.address).then(function(){
  		return deployer.deploy(OfficalCircle,"truffle's Circle","0xe559eddf4367634912316d71d4f0b52766c64a79");
  	})
  })
};
