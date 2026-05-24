// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ProtocolProvenanceRegistry {

    struct ProtocolRecord {
        string protocolName;
        address contractAddress;
        string version;
        string auditHash;
        string commitHash;
        string auditor;
        uint256 timestamp;
    }

    mapping(address => ProtocolRecord[]) private records;

    event ProtocolRegistered(
        address indexed contractAddress,
        string version,
        string auditHash,
        uint256 timestamp
    );

    function registerProtocolRecord(
        string memory protocolName,
        address contractAddress,
        string memory version,
        string memory auditHash,
        string memory commitHash,
        string memory auditor
    ) public {

        ProtocolRecord memory newRecord = ProtocolRecord({
            protocolName: protocolName,
            contractAddress: contractAddress,
            version: version,
            auditHash: auditHash,
            commitHash: commitHash,
            auditor: auditor,
            timestamp: block.timestamp
        });

        records[contractAddress].push(newRecord);

        emit ProtocolRegistered(
            contractAddress,
            version,
            auditHash,
            block.timestamp
        );
    }

    function getProtocolHistory(
        address contractAddress
    ) public view returns (ProtocolRecord[] memory) {

        return records[contractAddress];
    }
}