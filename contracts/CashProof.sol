// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./helpers/Structs.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract CashProof is Struct {
    address private owner;
    Metadata private metadata;
    uint256 public recipientCount;

    /* MAPPINGS */
    mapping(address => bool) public isRecipient;
    /* MAPPINGS */

    // Event to log balance verification
    event FundVerified(address verifier, uint256 balance, string attestationId);

    constructor(
        string memory _name,
        string memory _description,
        uint256 _balance,
        string memory _recipientName,
        address _recipientAddress,
        string memory _cid,
        string memory _network
    ) {
        // Constructor to initialize the contract
        owner = msg.sender;
        metadata = Metadata(
            msg.sender,
            _network,
            block.timestamp,
            _name,
            _description,
            _balance,
            _recipientName,
            _recipientAddress,
            _cid,
            0,
            ""
        );
    }

    // get owner
    function getOwner() public view returns (address) {
        return owner;
    }

    function validate(
        string memory _attestationId
    ) public returns (Metadata memory) {
        // verify address
        // get balance of sender
        uint256 balance = address(msg.sender).balance;
        uint256 targetBalance = metadata.balance;
        // only the recipient address can validate
        require(
            msg.sender == metadata.recipientAddress,
            "Only the intended recipient can validate their balance"
        );
        // require at least balance of the metadata
        require(balance >= targetBalance, "Balance is less than expected");
        // only validate once
        require(metadata.validatedAt == 0, "Balance already validated");
        // set validatedAt timestamp
        metadata.validatedAt = block.timestamp;
        metadata.attestationId = _attestationId;
        // emit event
        emit FundVerified(msg.sender, balance, _attestationId);
        return metadata;
    }

    // get metadata
    function getMetadata() public view returns (Metadata memory) {
        return metadata;
    }
}
