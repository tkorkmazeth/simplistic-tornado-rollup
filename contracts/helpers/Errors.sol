// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface Error {
    error InvalidDate(uint256 timestamp);
    error OnlyOwner();
    error OnlyRecipient();
    error Expired();
    error InvalidAddress(address failedAddress);
    error AlreadyAdded(address recipient);
    error AlreadyValidated(bytes32 requestId);
    error InsufficientBalance();
}
