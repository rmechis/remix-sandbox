// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//contract 0x0822f68cdac321d984bdb2821c6141fd10422431
contract CountryNFT is ERC721, Ownable {
    uint256 public tokenCounter;
    string[] public countries;
    mapping(string => bool) private countryExists;
    mapping(uint256 => string) private tokenIdToCountry;

    event NFTCreated(address to, uint256 tokenId, string country);

    constructor() ERC721("CountryNFT", "CNT") Ownable(msg.sender) {
        tokenCounter = 0;
        countries = ["Brazil", "Argentina", "Germany", "France", "Japan", "Australia", "Canada", "Italy", "Spain", "Portugal"];
    }

    function createNFT(address to) public onlyOwner returns (uint256) {
        require(tokenCounter < 10, "All NFTs have been minted");

        string memory country = getRandomCountry();
        uint256 newTokenId = tokenCounter;
        _safeMint(to, newTokenId);
        tokenIdToCountry[newTokenId] = country;

        countryExists[country] = true;
        tokenCounter += 1;

        emit NFTCreated(to, newTokenId, country);
        return newTokenId;
    }

    function getRandomCountry() internal returns (string memory) {
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % countries.length;
        string memory country = countries[randomIndex];

        while (countryExists[country]) {
            randomIndex = (randomIndex + 1) % countries.length;
            country = countries[randomIndex];
        }

        return country;
    }

    function getCountryByTokenId(uint256 tokenId) public view returns (string memory) {
        require(_existsCustom(tokenId), "Token ID does not exist");
        return tokenIdToCountry[tokenId];
    }

    function _existsCustom(uint256 tokenId) internal view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }
}
