pragma solidity ^0.4.24;

/**
 * Author: xaxa 
 */

/** @title Auditors Registry. */
/** @dev Allows to self register as an auditor, with a stake, and validators to consolidate your position */

contract AuditorsRegistry {
    mapping(address => string) public auditors;
    mapping(address => address[]) public validations;

    function selfRegistration(string _name) public payable {
      //primitive barrier to entry, a stake
      require(msg.value == 1 ether);
      auditors[msg.sender]= _name;
    }

    function getAuditor(address _addr) public view returns(string) {
        return auditors[_addr];
    }

    function validateAuditor(address _addr) public {
      validations[_addr].push(msg.sender);
    }

    function getValidator(address _addr, uint _index) public view returns(address) {
        return validations[_addr][_index];
    }

}
