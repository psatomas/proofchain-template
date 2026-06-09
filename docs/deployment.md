# 🚀 ProofChain — Deployment Guide

This document describes how to deploy and run ProofChain in both **local development** and **Sepolia testnet production mode**.

---

## 🌐 Prerequisites

Before starting, ensure you have:

- Node.js (>= 18)
- npm or yarn
- MetaMask wallet
- Sepolia ETH (for testnet deployment)
- RPC provider (Alchemy / Infura recommended)

---

## 📦 Installation

Install all dependencies:

```bash
npm install
```

---

## ⚙️ Environment Setup

Create a `.env` file in the root directory:

```env
PRIVATE_KEY=your_wallet_private_key
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
ETHERSCAN_API_KEY=your_etherscan_key
```

### Frontend environment (important)

Inside `frontend/`:

```env
VITE_CONTRACT_ADDRESS=0xYourDeployedContractAddress
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
```

---

## 🧱 Compile Smart Contracts

```bash
npx hardhat compile
```

This generates:
- ABI files
- Typechain types
- Artifacts

---

## 🧪 Local Development Deployment (Optional)

### Start local blockchain:

```bash
npx hardhat node
```

### Deploy locally:

```bash
npx hardhat run scripts/deploy.ts --network localhost
```

### Run tests:

```bash
npx hardhat test
```

---

## 🌍 Sepolia Testnet Deployment (Production Mode)

This is the **main deployment target for ProofChain**.

### Step 1 — Ensure wallet has Sepolia ETH
Use:
- https://sepoliafaucet.com/
- Alchemy faucet (if available)

---

### Step 2 — Deploy contract

```bash
npx hardhat run scripts/deploy.ts --network sepolia
```

---

### Step 3 — Verify deployment output

After deployment, you will receive:

```text
Contract deployed to: 0x...
```

This address must be saved in:

```
frontend/.env
```

---

### Step 4 — Verify on explorer (optional but recommended)

If configured:

```bash
npx hardhat verify --network sepolia <CONTRACT_ADDRESS>
```

---

## 🔗 Frontend Deployment

After contract deployment:

```bash
cd frontend
npm install
npm run dev
```

Frontend will connect to:

- MetaMask wallet
- Sepolia smart contract
- On-chain provenance system

---

## 🧾 Deployment Architecture Flow

```text
Hardhat Script
   ↓
Solidity Contract Deployment
   ↓
Sepolia Blockchain
   ↓
Contract Address Generated
   ↓
Frontend Configuration (VITE_CONTRACT_ADDRESS)
   ↓
React + Ethers.js Integration
```

---

## ⚠️ Common Issues

### 1. “Insufficient funds”
- Wallet does not have Sepolia ETH

### 2. “Network mismatch”
- MetaMask not set to Sepolia network

### 3. “Invalid RPC”
- Incorrect Infura/Alchemy endpoint

### 4. Contract not found in frontend
- Missing `VITE_CONTRACT_ADDRESS`

---

## 🔐 Security Notes

- Never expose `PRIVATE_KEY` in frontend
- Only use environment variables for secrets
- Sepolia is a public testnet — no real financial risk but still sensitive

---

## 🏁 Final Result After Deployment

Once deployed successfully, ProofChain provides:

- Live smart contract on Sepolia
- Publicly verifiable transaction history
- Fully functional frontend dApp
- End-to-end provenance tracking system

---

## 🚀 Summary

Deployment process transforms ProofChain from local dApp into a **publicly verifiable blockchain system**, enabling real audit provenance tracking on Ethereum Sepolia.

---