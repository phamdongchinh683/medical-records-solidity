// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./users/UserRegistry.sol";
import "./access/AccessControl.sol";
import "./models/Structs.sol";
import "./interfaces/IMedicalRecord.sol";

contract MedicalRecord is UserRegistry, AccessControl, IMedicalRecord {
    using Structs for Structs.Record;

    mapping(address => Structs.Record[]) private records;

    function addRecord(string memory ipfsHash) external override {
        require(isPatient[msg.sender], "Not a registered patient");
        records[msg.sender].push(Structs.Record(ipfsHash, block.timestamp));
    }

    function viewRecords(address patient)
        external
        view
        override
        returns (string[] memory, uint256[] memory) 
    {
        require(checkAccess(patient, msg.sender), "You do not have access");
        uint256 length = records[patient].length;
        string[] memory hashes = new string[](length);
        uint256[] memory timestamps = new uint256[](length);

        for (uint256 i = 0; i < length; i++) {
            hashes[i] = records[patient][i].ipfsHash;
            timestamps[i] = records[patient][i].timestamp;
        }

        return (hashes, timestamps);
    }
}
