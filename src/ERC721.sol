// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "openzeppelin-contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/utils/Counters.sol";

/**
 * @title ERC721NFT
 * @dev A basic ERC721 non-fungible token contract with burning functionality and an owner.
 */
contract ERC721NFT is ERC721, ERC721Burnable, Ownable {
  using Counters for Counters.Counter;

  Counters.Counter private _tokenIdCounter;

  /**
   * @dev Constructor function to initialize the ERC721 token with a given name, symbol, and owner.
   * @param _name The name of the ERC721 token.
   * @param _symbol The symbol of the ERC721 token.
   * @param _owner The address of the contract owner.
   */
  constructor(string memory _name, string memory _symbol, address _owner) ERC721(_name, _symbol) {
    _transferOwnership(_owner);
  }

  /**
   * @dev Safely mints a new ERC721 token to the specified address.
   * Only the contract owner can call this function.
   * @param to The address to which the token will be minted.
   */
  function safeMint(address to) public onlyOwner {
    uint256 tokenId = _tokenIdCounter.current();
    _tokenIdCounter.increment();
    _safeMint(to, tokenId);
  }
}
