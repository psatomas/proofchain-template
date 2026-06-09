# 🧱 ProofChain — Smart Contract Specification

This document describes the architecture, logic, and behavior of the core smart contract used in ProofChain:

> `ProtocolProvenanceRegistry.sol`

The contract is responsible for maintaining an **immutable, versioned registry of protocol audit provenance records on-chain**.

---

## 📌 Contract Overview

The contract acts as a **decentralized registry of protocol evolution**, enabling:

- Protocol registration
- Version tracking
- Audit integrity verification
- Historical provenance retrieval
- Ownership-controlled updates

It is deployed on **Ethereum Sepolia testnet**.

---

## 🧱 Core Design Philosophy

The contract is designed under the following principles:

- ⛓️ Immutability of historical records
- 🔐 Restricted write access (owner-only)
- 🧾 Cryptographic integrity via hashes
- 📦 Append-only data structure
- 🔍 Public read access for transparency

---

## 📦 Data Model

Each protocol entry is stored as a structured record:

```solidity
struct ProtocolRecord {
    string protocolName;
    uint256 version;
    address contractAddress;
    bytes32 auditHash;
    bytes32 commitHash;
    string auditor;
    uint256 timestamp;
}
```

---

## 🗂️ Storage Layout

Records are organized by contract address:

```solidity
mapping(address => ProtocolRecord[]) private records;
```

### Behavior:
- Each address has its own history
- Records are appended (never overwritten)
- Full version history is preserved

---

## 🔐 Access Control

### Owner Restriction

Only the contract owner can register new protocol records:

```solidity
modifier onlyOwner()
```

### Purpose:
- Prevent unauthorized protocol registration
- Ensure data integrity at write-time

---

## 🧾 Core Functions

---

### 1. `registerProtocol(...)`

Registers a new protocol provenance record.

#### Parameters:
- `protocolName`
- `contractAddress`
- `version`
- `auditHash`
- `commitHash`
- `auditor`

#### Behavior:
- Creates a new `ProtocolRecord`
- Appends it to history
- Emits event for off-chain indexing

#### Security:
- Restricted via `onlyOwner`

---

### 2. `getProtocolHistory(address)`

Returns full provenance history for a protocol.

#### Output:
- Array of `ProtocolRecord`

#### Purpose:
- Enables full audit trail reconstruction
- Used by Explorer UI

---

### 3. `getLatestRecord(address)`

Returns the most recent protocol version.

#### Purpose:
- Quick access to current state
- Used in dashboard UI

---

### 4. `getRecordCount(address)`

Returns number of stored versions.

#### Purpose:
- Version tracking
- UI metadata display

---

## 📡 Events

### `ProtocolRegistered`

Emitted when a new protocol record is created:

```solidity
event ProtocolRegistered(
    address indexed contractAddress,
    string protocolName,
    uint256 version,
    bytes32 auditHash,
    uint256 timestamp
);
```

### Purpose:
- Enables off-chain indexing
- Supports explorer functionality
- Improves transparency

---

## 🔒 Security Model

The contract enforces:

### 1. Write Protection
Only owner can mutate state

### 2. Append-only Storage
No updates or deletions allowed

### 3. Deterministic State
Same inputs always produce same stored result

### 4. On-chain Integrity
All records are permanently stored in Ethereum state

---

## 🧠 Cryptographic Guarantees

### Audit Hash
- Represents hashed PDF or audit document
- Ensures document integrity

### Commit Hash
- Represents code version reference
- Links protocol version to repository state

Together they ensure:

> “What was audited is exactly what was deployed”

---

## 🌐 Deployment Context

- Network: Ethereum Sepolia
- Deployment tool: Hardhat Ignition / scripts
- Interaction: Ethers.js v6
- Wallet: MetaMask / deployer key

---

## 🧾 State Behavior Summary

```text
Register → Append record → Emit event → Persist on-chain

Read → Query mapping → Return historical dataset
```

No deletion, no modification, no rollback.

---

## ⚠️ Limitations

- No pagination for large histories (future improvement)
- Owner centralized write control (intentional for MVP trust model)
- No upgradeability pattern (immutable deployment)

---

## 🚀 Summary

The `ProtocolProvenanceRegistry` contract serves as the **trust anchor of ProofChain**, providing:

- Immutable audit trail
- Version-controlled protocol history
- Cryptographic verification of integrity
- Transparent public read access

It is the foundation that guarantees the reliability of the entire system.

---