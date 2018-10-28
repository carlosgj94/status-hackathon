var LoanRegistry = artifacts.require('./LoanRegistry.sol')
var AuditorsRegistry = artifacts.require('./AuditorsRegistry.sol')

var Bond = artifacts.require('./Bond.sol')

module.exports = function (deployer) {
  return deployer.then(async () => {
    const loanRegistry = await LoanRegistry.deployed()
    // First Bond
    await deployer.deploy(
      Bond,
      11111,
      80808288,
      5,
      2,
      10,
      loanRegistry.address,
      '0xc66bD3780C297Baa1d910923c8b47Dce4b284076'
    )
    // Second Bond
    await deployer.deploy(
      Bond,
      3499,
      1540685256509,
      888588,
      5,
      3,
      loanRegistry.address,
      '0x3009Fb76bcA35C0675eC087f281B8b964b7ccbc5'
    )
    // Third Bond
    await deployer.deploy(
      Bond,
      7890,
      80808288,
      88855888,
      2,
      10,
      loanRegistry.address,
      '0x0fb12568c9cdeadfefb70ecb33d2ecbd4a6a6432'
    )
    // fourth Bond
    await deployer.deploy(
      Bond,
      7890,
      80808288,
      88855888,
      2,
      10,
      loanRegistry.address,
      '0xf1d09dd338d4a2affbf0cfe01a89381550177c1a'
    )
    const auditorsRegistry = await AuditorsRegistry.deployed()
    auditorsRegistry.selfRegistration("S&P", { "from": "0xc66bD3780C297Baa1d910923c8b47Dce4b284076" })
    auditorsRegistry.selfRegistration("His Grandma", { "from": "0x3009Fb76bcA35C0675eC087f281B8b964b7ccbc5" })
    auditorsRegistry.selfRegistration("Anymous & Registered", { "from": "0x0fb12568c9cdeadfefb70ecb33d2ecbd4a6a6432" })
    auditorsRegistry.selfRegistration("just a guy", { "from": "0xf1d09dd338d4a2affbf0cfe01a89381550177c1a" })
  })
}
