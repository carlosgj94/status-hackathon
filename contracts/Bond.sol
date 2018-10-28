pragma solidity ^0.4.24;

/**
 * Author: Carlos Gonzalez -- Github: carlosgj94
 */
/** @title Bond . */

import "./LoanRegistry.sol";


contract Bond {
    struct BondStruct {
        uint lender;
        uint borrower;
        address borrowerAddress;
        uint principal;
        uint bidTimeFrame;
        uint amountRepaid;
        bool complete;
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
            borrower: _borrower,
            borrowerAddress: address(0),
            principal: _principal,
            bidTimeFrame: _bidTimeFrame,
            amountRepaid: 0,
            complete: false,
            defaulted: false,
            creationDate: now,
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

    function getLender() public view returns(uint) {
        return bond.lender;
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
        return bond.complete;
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
        if (bond.creationDate + bond.bidTimeFrame < now)
            return true;
        else
            return false;
    }

    function addBid(uint _interestRate, uint _bloomId) public returns(bool) {
        require(_interestRate < bond.interestRate);
        require(bond.creationDate + bond.bidTimeFrame < now);
        require(bond.complete == false);
        
        bond.borrower = _bloomId;
        bond.borrowerAddress = msg.sender;
        bond.interestRate = _interestRate;
        return true;
    }

    function giveLoan() public payable {
        require(bond.creationDate + bond.bidTimeFrame > now);
        require(bond.complete == false);
        // require(bond.creationDate + bond.bidTimeFrame > now);

        if (msg.value >= bond.principal || address(this).balance >= bond.principal) {
            bond.granted = true;
        }
    }

    function payCouponRate() public payable {
        require(bond.complete == true);
        require(bond.creationDate + bond.bidTimeFrame > now);
        
        bond.amountRepaid += msg.value;
        if (getTotalToPay() <= bond.amountRepaid) {
            bond.complete = true;
        }
        bond.borrowerAddress.transfer(msg.value);
    }

    function setDefaulted() public {
        require(bond.complete != false);
        require(isBiddingTime() == false);

        uint _yearsPassed = (block.number - bond.creationDate + bond.bidTimeFrame)/2102400;
        if (
            (_yearsPassed >= bond.duration && bond.complete == false) ||
            (bond.amountRepaid < _yearsPassed * (bond.interestRate * 100) / bond.principal)
        ) {
            bond.defaulted = true;
            // These scammers...
            // Do something in here
        }

    }
}
