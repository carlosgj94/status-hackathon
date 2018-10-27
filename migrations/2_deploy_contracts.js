var LoanRegistry = artifacts.require('./LoanRegistry.sol')

module.exports = function (deployer) {
  deployer.deploy(LoanRegistry)
}
