// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts/token/ERC1155/ERC1155.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "openzeppelin-contracts/token/ERC1155/extensions/ERC1155Supply.sol";

/**
 * @title ERC1155NFT
 * @dev An ERC1155 token contract with additional features, including minting, burning, and supply management.
 */
contract ERC1155NFT is ERC1155, Ownable, ERC1155Burnable, ERC1155Supply {
  /**
   * @dev Constructor function to initialize the contract with a given base URI and set the contract owner.
   * @param _uri The base URI for the token metadata.
   * @param _owner The address of the contract owner.
   */
  constructor(string memory _uri, address _owner) ERC1155(_uri) {
    _transferOwnership(_owner);
  }

  /**
   * @dev Sets the base URI for the token metadata. Only the contract owner can call this function.
   * @param newuri The new base URI to be set.
   */
  function setURI(string memory newuri) public onlyOwner {
    _setURI(newuri);
  }

  /**
   * @dev Mints a new ERC1155 token to the specified account.
   * @param account The address of the account to which the tokens will be minted.
   * @param id The token ID to be minted.
   * @param amount The amount of tokens to be minted.
   * @param data Additional data to be passed along with the minting operation (optional).
   */
  function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
    _mint(account, id, amount, data);
  }

  /**
   * @dev Mints multiple ERC1155 tokens to the specified account.
   * @param to The address of the account to which the tokens will be minted.
   * @param ids An array of token IDs to be minted.
   * @param amounts An array specifying the amount of each token to be minted.
   * @param data Additional data to be passed along with the minting operation (optional).
   */
  function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
    _mintBatch(to, ids, amounts, data);
  }

  // The following functions are overrides required by Solidity.

  /**
   * @dev Hook function that is called before any token transfer.
   * It checks for the validity of the transfer and updates the token supply.
   * @param operator The address which initiated the token transfer (e.g., msg.sender).
   * @param from The address from which the tokens are being transferred.
   * @param to The address to which the tokens are being transferred.
   * @param ids An array of token IDs that are being transferred.
   * @param amounts An array specifying the amount of each token to be transferred.
   * @param data Additional data to be passed along with the token transfer (optional).
   */
  function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal override(ERC1155, ERC1155Supply) {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
  }
}
