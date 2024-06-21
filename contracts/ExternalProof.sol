// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./helpers/Structs.sol";
import "./helpers/Events.sol";
import "./helpers/Errors.sol";

contract ExternalProof is Struct, Events, Error {
    /* MAPPINGS */
    mapping(bytes32 => Request) public requests;

    /* MAPPINGS */

    function requestProof(
        address recipient,
        uint256 amount
    ) external returns (bytes32) {
        bytes32 requestId = keccak256(
            abi.encodePacked(msg.sender, recipient, amount, block.timestamp)
        );
        requests[requestId] = Request(
            msg.sender,
            recipient,
            amount,
            block.timestamp,
            false
        );

        emit ProofRequested(requestId, msg.sender, recipient, amount);
        return requestId;
    }

    function validateProof(bytes3 requestId, uint256 balance) external {
        Request storage req = requests[requestId];
        if (req.recipient != msg.sender) {
            revert OnlyRecipient();
        }
        if (req.validated) {
            revert AlreadyValidated(requestId);
        }
        if (balance < req.amount) {
            revert InsufficientBalance();
        }
        req.validated = true;
        emit ProofValidated(requestId);
    }

    function getRequest(
        bytes32 requestId
    ) external view returns (Request memory) {
        return requests[requestId];
    }
}
