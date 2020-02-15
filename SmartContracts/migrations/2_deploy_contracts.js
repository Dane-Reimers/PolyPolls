var ElectionManager=artifacts.require ("./ElectionManager.sol");

module.exports = function(deployer) {
      deployer.deploy(ElectionManager);
}