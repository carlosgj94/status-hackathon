var LoanRegistry = artifacts.require('./LoanRegistry.sol')
var Bond = artifacts.require('./Bond.sol')

module.exports = function (deployer) {
  return deployer.then(async () => {
    const loanRegistry = await LoanRegistry.deployed()
    // First Bond
    await deployer.deploy(
      Bond,
      7890,
      80808288,
      88855888,
      2,
      10,
      loanRegistry.address,
      '0xc66bD3780C297Baa1d910923c8b47Dce4b284076'
    )
    // Second Bond
    await deployer.deploy(
      Bond,
      7890,
      1540685256509,
      88855888,
      5,
      3,
      loanRegistry.address,
      '0xc66bD3780C297Baa1d910923c8b47Dce4b284076'
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
      '0xD48F0C3B257584181e144B51F8D55ac7cFD01d50'
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
      '0xc66bD3780C297Baa1d910923c8b47Dce4b284076'
    )
  })
}
