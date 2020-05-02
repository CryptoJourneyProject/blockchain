const CryptoJourney = artifacts.require("CryptoJourney");

module.exports = function(deployer) {
  deployer.deploy(CryptoJourney);
};