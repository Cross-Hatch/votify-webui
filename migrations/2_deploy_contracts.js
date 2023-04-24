var Votify = artifacts.require("./Votify.sol");

module.exports = function(deployer) {
  deployer.deploy(Votify);
};
