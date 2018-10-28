pragma solidity ^0.4.24;

/**
 * Author: Carlos Gonzalez -- Github: carlosgj94
 */
/** @title Bond . */

import "./LoanRegistry.sol";


contract Bond {

    event BondTransfered(address newOwner, uint bloomId);

    struct BondStruct {
        uint lender;
        address lenderAddress;
        uint borrower;
        address borrowerAddress;
        uint principal;
        uint bidTimeFrame;
        uint amountRepaid;
        bool defaulted;
        uint creationDate;
        uint duration; // The amount of years
        uint interestRate;
        bool granted;
        uint rating;
        address auditor;
    }

    BondStruct public bond;
  
    constructor (
        uint _borrower,
        uint _principal,
        uint _bidTimeFrame,
        uint _duration,
        uint _interestRate,
        address _loanRegistry,
        address _auditor
    ) public {
        BondStruct memory _bond = BondStruct({
            lender: 0,
            lenderAddress: address(0),
            borrower: _borrower,
            borrowerAddress: address(0),
            principal: _principal,
            bidTimeFrame: _bidTimeFrame,
            amountRepaid: 0,
            defaulted: false,
            creationDate: block.number,
            duration: _duration,
            interestRate: _interestRate,
            granted: false,
            rating: 0,
            auditor: _auditor
        });
        bond = _bond;

        LoanRegistry _loanRegistryContract = LoanRegistry(_loanRegistry);

        require(_loanRegistryContract.addLoan(_borrower, address(this)) == true);
    }

    function getBond() 
    public view returns(
        uint,
        address,
        uint,
        address,
        uint,
        uint,
        uint,
        bool,
        bool,
        uint,
        uint,
        uint,
        uint,
        address
    ) {
        return 
        (
            bond.lender,
            bond.lenderAddress,
            bond.borrower,
            bond.borrowerAddress,
            bond.principal,
            bond.bidTimeFrame,
            bond.amountRepaid,
            bond.defaulted,
            getComplete(),
            bond.creationDate,
            bond.duration,
            bond.interestRate,
            bond.rating,
            bond.auditor
        );
    }

    function getLender() public view returns(uint) {
        return bond.lender;
    }

    function getLenderAddress() public view returns(address) {
        return bond.lenderAddress;
    }

    function getBorrower() public view returns(uint) {
        return bond.borrower;
    }

    function getBorrowerAddress() public view returns(address) {
        return bond.borrowerAddress;
    }

    function getPrincipal() public view returns(uint) {
        return bond.principal;
    }

    function bidTimeFrame() public view returns(uint) {
        return bond.bidTimeFrame;
    }

    function getAmountRepaid() public view returns(uint) {
        return bond.amountRepaid;
    }

    function getComplete() public view returns(bool) {
        if (bond.creationDate + bond.bidTimeFrame + bond.duration <= block.number &&
            bond.amountRepaid >= getTotalToPay()) {
            return true;
        }
    }

    function getDefaulted() public view returns(bool) {
        return bond.defaulted;
    }

    function getCreationDate() public view returns(uint) {
        return bond.creationDate;
    }

    function getDuration() public view returns(uint) {
        return bond.duration;
    }

    function getInterestRate() public view returns(uint) {
        return bond.interestRate;
    }

    function getTotalToPay() public view returns(uint) {
        require(bond.granted == true);

        return bond.principal + (((bond.interestRate*100) / bond.principal) * bond.duration);
    }

    function getRating() public view returns(uint) {
        return bond.rating;
    }

    function getAuditor() public view returns(address) {
        return bond.auditor;
    }

    function setRating(uint rate) public {
        require(msg.sender == bond.auditor);
        require(rate < 32);

        bond.rating = rate;
    }

    function isBiddingTime() public view returns(bool) {
        if (bond.creationDate + bond.bidTimeFrame < block.number)
            return true;
        else
            return false;
    }

    function addBid(uint _interestRate, uint _bloomId) public returns(bool) {
        require(_interestRate < bond.interestRate);
        // require(bond.creationDate + bond.bidTimeFrame < block.number);
        require(getComplete() == false);
        
        bond.borrower = _bloomId;
        bond.borrowerAddress = msg.sender;
        bond.interestRate = _interestRate;
        return true;
    }

    function giveLoan() public payable {
        require(bond.creationDate + bond.bidTimeFrame > block.number);
        require(getComplete() == false);
        // require(bond.creationDate + bond.bidTimeFrame > block.number);

        if (msg.value >= bond.principal || address(this).balance >= bond.principal) {
            bond.granted = true;
        }
    }

    function payCouponRate() public payable {
        require(getComplete() == true);
        require(bond.creationDate + bond.bidTimeFrame > block.number);
        
        bond.amountRepaid += msg.value;
        bond.borrowerAddress.transfer(msg.value);
    }

    function setDefaulted() public {
        require(getComplete() == false);
        require(isBiddingTime() == false);

        uint _yearsPassed = (block.number - bond.creationDate + bond.bidTimeFrame)/2102400;
        if (
            (_yearsPassed >= bond.duration && getComplete() == false) ||
            (bond.amountRepaid < _yearsPassed * (bond.interestRate * 100) / bond.principal)
        ) {
            bond.defaulted = true;
            // These scammers...
            // Do something in here
        }

    }

    function transferBond(address _newOwner, uint _bloomId) public {
        require(msg.sender == bond.lenderAddress);

        bond.lenderAddress = _newOwner;
        bond.lender = _bloomId;
        emit BondTransfered(_newOwner, _bloomId);
    }
}
