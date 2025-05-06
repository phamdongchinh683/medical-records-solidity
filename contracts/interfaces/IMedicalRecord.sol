// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface IMedicalRecord {
    function addRecord(string memory ipfsHash) external;
    function viewRecords(address patient) external view returns (string[] memory, uint[] memory); 
}
