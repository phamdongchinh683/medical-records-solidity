// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract AccessControl {
    mapping(address => mapping(address => bool)) internal access;
    mapping(address => address[]) private grantedDoctors;

    event AccessGranted(address indexed patient, address indexed doctor);
    event AccessRevoked(address indexed patient, address indexed doctor);

    function grant(address doctor) public {
        if (!access[msg.sender][doctor]) {
            access[msg.sender][doctor] = true; // access permission for doctor
            grantedDoctors[msg.sender].push(doctor); // push in a array
            emit AccessGranted(msg.sender, doctor);
        }
    } // access permission for that doctor

   function revoke(address doctor) public {
    if (access[msg.sender][doctor]) {
        access[msg.sender][doctor] = false;

        address[] storage doctors = grantedDoctors[msg.sender];
        for (uint i = 0; i < doctors.length; i++) {
            if (doctors[i] == doctor) {
                doctors[i] = doctors[doctors.length - 1];
                doctors.pop(); 
                break;
            }
        }

        emit AccessRevoked(msg.sender, doctor);
    }
}
    function checkAccess(address patient, address doctor)
        public
        view
        returns (bool)
    {
        if (patient == doctor) {
            return true; // A patient can always access their own records
        }
        return access[patient][doctor]; // check if doctor has access
    }

    // check doctor that is can access medical records
    function getGrantedDoctors() external view returns (address[] memory) {
        return grantedDoctors[msg.sender];
    }
}
