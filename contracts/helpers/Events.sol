// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface Events {
    ///@notice to log balance verification
    event FundVerified(address verifier, uint256 balance, string attestationId);
    ///@notice to log external proof requests
    event ProofRequested(
        bytes32 requestId,
        address requester,
        address recipient,
        uint256 amount
    );
    ///@notice to log validated proof
    event ProofValidated(bytes32 requestId);
}
