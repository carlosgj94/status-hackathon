var LoanRegistry = artifacts.require('./LoanRegistry.sol')
var Bond = artifacts.require('./Bond.sol')

module.exports = function (deployer) {
  deployer.deploy(LoanRegistry)
  deployer.deploy(Bond)
}
