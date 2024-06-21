# CashProof

## Overview

CashProof is a revolutionary solution designed for high-value purchases requiring proof of funds. It allows buyers to securely prove their financial capability without exposing sensitive bank statements or private keys. CashProof leverages smart contracts and decentralized storage to provide a seamless, secure, and efficient proof of funds process.

## Live Demo

Coming soon...

## Inspiration

The idea for CashProof emerged from the need for a reliable method to verify proof of funds for high-value transactions, such as real estate deals, where buyers must demonstrate financial capability. Traditional methods require sharing sensitive bank statements, which poses privacy risks and is cumbersome. CashProof solves this by allowing users to assert their financial standing securely and efficiently.

## How It Works

### Buyers

1. **Secure Connection:** Connect wallets to show ownership of accounts.
2. **Generate Proofs:** Create smart contract transactions and sign protocol attestations demonstrating sufficient funds for a specific transaction.
3. **Share Proofs:** Share these proofs with sellers or realtors without revealing personal details.

### Sellers and Realtors

1. **Verify Proofs:** Use the app to confirm a buyer's financial eligibility.
2. **Streamlined Process:** Expedite serious offers by eliminating lengthy document verification.

## Additional Features

1. **Multi-Signature Verification:**

   - Enhance security by allowing multiple recipients to validate the funds, ensuring all required parties acknowledge the proof of funds.

2. **Expiry Date for Validation Requests:**

   - Set an expiry timestamp for fund verification requests to ensure the proof is timely and relevant.

3. **Support for Multiple Assets/Currencies:**

   - Support different ERC20 tokens and other assets, providing flexibility in the type of assets used for proof of funds.

4. **Off-Chain Data Integration:**

   - Integrate with decentralized storage solutions like Filecoin for secure handling of additional material related to fund requests.

5. **Third-Party Integration:**

   - Develop APIs for third-party applications to request and verify proof of funds seamlessly.

6. **Reputation System:**
   - Implement a reputation system to track users' interactions and assign scores based on their historical proofs, validations, and transactions.

## Technologies Used

- **Sign Protocol:** Utilized for generating and verifying signatures to ensure the authenticity and integrity of attestations without revealing sensitive information.
- **Filecoin:** Used for secure file storage, ensuring that additional material related to the fund request is securely stored and accessible only to authorized parties.
- **OpenZeppelin:** Incorporates industry-standard security practices and functionalities, such as ownership management and protection against reentrancy attacks.

## Example Attestation Process

1. A buyer connects their wallet and initiates a proof of funds request.
2. A smart contract is deployed, encapsulating the balance request details.
3. The recipient validates the request, triggering a blockchain event and updating the attestation.
4. Both parties can review the completed attestation on the sign protocol explorer.

## Contract Overview

### CashProof Contract (Solidity)

- **Metadata Struct:** Stores information about the fund request, including owner, network, creation timestamp, description, balance, recipient details, CID for attachments, validation timestamp, and attestation ID.
- **Assets:** Supports multiple assets, enabling proof of funds using different tokens.
- **Security:** Implements `ReentrancyGuard` for protection against reentrancy attacks and uses `Ownable` for secure ownership management.
- **Validation:** Ensures only designated recipients can validate the funds, checks expiry dates, and requires sufficient balance.

### Third-Party Integration

- **Request Proof:** Allows third parties to request proof of funds, generating a unique request ID.
- **Validate Proof:** Enables recipients to validate the request, ensuring the balance meets the specified amount.

### Reputation System

- **Reputation Tracking:** Maintains and updates users' reputation scores based on their activities and interactions within the platform.

---

Front end of this application and additional progress is still in progress. The final project is gonna include all of described features.
