// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface Error {
    error InvalidDate(uint256 timestamp);
    error OnlyOwner();
    error OnlyRecipient();
    error Expired();
}
