// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/interfaces/IERC165.sol";

import "./helpers/Structs.sol";
import "./helpers/Errors.sol";
import "./interfaces/IERC20.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract CashProof is Struct, Error, ReentrancyGuard, Ownable {
    Metadata private metadata;
    Asset[] public assets;

    uint256 public recipientCount;
    uint256 public expiryTimeStamp;

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
        string memory _network,
        uint256 _expiryTimeStamp
    ) Ownable(msg.sender) {
        if (_expiryTimeStamp <= block.timestamp) {
            revert InvalidDate(_expiryTimeStamp);
        }
        expiryTimeStamp = _expiryTimeStamp;
        _transferOwnership(msg.sender);

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

    /* READ ONLY */

    function getMetadata() public view returns (Metadata memory) {
        return metadata;
    }

    /* READ ONLY */

    /* STATE CHANGERS */
    function validate(
        string memory _attestationId
    ) public returns (Metadata memory) {
        if (!isRecipient[msg.sender]) {
            revert OnlyRecipient();
        }

        if (block.timestamp > expiryTimeStamp) {
            revert Expired();
        }
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

    function addRecipient(address _recipient) external onlyOwner {
        isRecipient[_recipient] = true;
        recipientCount++;
    }

    function addAsset(
        address _tokenAddress,
        uint256 amount
    ) external onlyOwner {
        assets.push(Asset(_tokenAddress, amount));
    }

    function validateAssets() public view {
        for (uint256 i = 0; i < assets.length; i++) {
            uint256 balance = IERC20(assets[i].tokenAddress).balanceOf(
                msg.sender
            );
            require(
                balance >= assets[i].amount,
                "Insufficient balance for asset"
            );
        }
    }

    /* STATE CHANGERS */

    /* INTERNAL FUNCS */
    function _supportsInterface(
        address _addr,
        bytes4 iface
    ) internal view returns (bool) {
        return IERC165(_addr).supportsInterface(iface);
    }
    /* INTERNAL FUNCS */
}
