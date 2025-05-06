// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract UserRegistry {
    mapping(address => bool) public isPatient;
    mapping(address => bool) public isDoctor;

    function registerAsPatient() public {
        require(!isPatient[msg.sender], "This account already registered");
        isPatient[msg.sender] = true;
    }

    function registerAsDoctor() public {
        require(!isDoctor[msg.sender], "This account already registered");
        isDoctor[msg.sender] = true;
    }
}
