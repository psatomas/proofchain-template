# 🧪 ProofChain — Testing Strategy

This document describes the testing architecture and validation strategy used in ProofChain.

The goal of testing is to ensure **correctness of smart contract behavior, access control enforcement, and reliable Web3 integration**.

---

## 🧭 Testing Philosophy

ProofChain follows a **deterministic testing model**:

- Smart contracts are tested in isolation
- Blockchain state is simulated using Hardhat Network
- All test results are reproducible
- Both positive and negative scenarios are validated

---

## 🧱 Testing Stack

- Hardhat Test Runner
- Mocha (test framework)
- Chai (assertion library)
- Hardhat Network (in-memory EVM)

---

## 📁 Test Location

All smart contract tests are located in:

```
/test/ProtocolProvenanceRegistry.ts
```

---

## 🧪 Test Coverage Overview

The test suite validates the core contract behavior across four dimensions:

---

## 1. 📦 Deployment Tests

### Objective:
Ensure the contract is deployed correctly.

### Validations:
- Contract instance exists
- Owner is correctly assigned
- Initial state is empty

### Expected Behavior:
- Deployment must succeed without revert
- Owner must match deployer address

---

## 2. 📝 Protocol Registration Tests

### Objective:
Validate successful protocol registration.

### Scenario:
Owner registers a protocol audit record.

### Validations:
- Record is stored in mapping
- Version is incremented correctly
- Audit hash is persisted
- Timestamp is generated

### Expected Result:
- Record count increases
- Latest record matches input data

---

## 3. 🔍 Data Retrieval Tests

### Objective:
Ensure historical provenance can be retrieved correctly.

### Validations:
- `getProtocolHistory()` returns full array
- `getLatestRecord()` returns most recent entry
- Data consistency across multiple entries

### Expected Result:
- Ordered history matches registration sequence
- No data corruption or missing entries

---

## 4. 🔐 Access Control Tests (Negative Cases)

### Objective:
Validate security restrictions.

### Scenario:
Non-owner attempts to register protocol data.

### Validations:
- Transaction reverts
- Custom error is triggered (`NotOwner`)
- State remains unchanged

### Expected Result:
- Unauthorized write is blocked
- No record is stored

---

## 🧾 Test Execution Flow

### Run local tests:

```bash
npx hardhat test
```

### Execution environment:

- Hardhat in-memory blockchain
- Fresh state per test run
- Deterministic signer accounts

---

## ⚙️ Test Accounts

Hardhat provides deterministic accounts:

- `ownerSigner` → contract deployer (authorized)
- `attackerSigner` → unauthorized user simulation

These are used to validate role-based access control.

---

## 🧠 Key Testing Principles

### 1. Isolation
Each test runs with a fresh blockchain state.

### 2. Determinism
Same inputs always produce same outputs.

### 3. Negative Testing
Security is validated by intentionally failing operations.

### 4. State Verification
All tests validate actual on-chain state, not UI behavior.

---

## 🔐 Security Validation Through Testing

Testing ensures:

- Only authorized accounts can write data
- Historical records cannot be modified
- Contract state remains consistent
- Invalid transactions are properly rejected

---

## 📊 Testing Scope Summary

| Category            | Status |
|---------------------|--------|
| Deployment          | ✅ Covered |
| Registration Logic  | ✅ Covered |
| Data Retrieval      | ✅ Covered |
| Access Control      | ✅ Covered |
| Frontend E2E Tests  | ⚠️ Not included (future improvement) |

---

## ⚠️ Current Limitations

- No automated frontend E2E testing (Cypress/Playwright not integrated)
- No fuzz testing or property-based testing
- No CI pipeline configured (GitHub Actions optional future step)

---

## 🚀 Future Improvements

- Add Foundry-based fuzz testing
- Add CI/CD pipeline for automated test runs
- Add frontend integration tests
- Add gas optimization benchmarking
- Add coverage reporting (solidity-coverage)

---

## 🏁 Summary

The ProofChain test suite ensures that:

- Smart contract logic is correct
- Access control is enforced
- Data integrity is preserved
- Historical provenance remains consistent

Testing is centered around **trustless verification of contract behavior under both valid and adversarial conditions**.

---