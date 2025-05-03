// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AccessControl {
    mapping(address => mapping(address => bool)) internal access;

    function grant(address doctor) public {
        access[msg.sender][doctor] = true;
    }

    function revoke(address doctor) public {
        access[msg.sender][doctor] = false;
    }

    function checkAccess(address patient, address doctor) public view returns (bool) {
        return access[patient][doctor];
    }
}
