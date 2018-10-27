pragma solidity ^0.4.24;

/**
 * Author: Carlos Gonzalez -- Github: carlosgj94
 */
/** @title Loan Registry. */

contract LoanRegistry {
    mapping(uint => address[]) public loansByBloomId;
    address[] public loans;

    event LoanCreated(uint bloomId, address loan);

    function addLoan(uint _bloomId, address _loanAddress) public returns(bool) {
        loansByBloomId[_bloomId].push(_loanAddress);
        loans.push(_loanAddress);
        emit LoanCreated(_bloomId, _loanAddress);
        return true;
    }
}
