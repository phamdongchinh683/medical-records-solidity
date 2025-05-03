// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract UserRegistry {
    mapping(address => bool) public isPatient;
    mapping(address => bool) public isDoctor;

    function registerAsPatient() public {
        require(!isPatient[msg.sender], "registered");
        isPatient[msg.sender] = true;
    }

    function registerAsDoctor() public {
        require(!isDoctor[msg.sender], "registered");
        isDoctor[msg.sender] = true;
    }
}
