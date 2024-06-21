// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface Struct {
    struct Metadata {
        address owner;
        string network;
        uint createdAt;
        string name;
        string description;
        uint256 balance;
        string recipientName;
        address recipientAddress;
        string cid; // optional cid pointer to attachment/s
        uint validatedAt;
        string attestationId;
    }

    struct Asset {
        address tokenAddress;
        uint256 amount;
    }

    struct Request {
        address requester;
        address recipient;
        uint256 amount;
        uint256 timestamp;
        bool validated;
    }
}
