pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";

contract ElectionToken is ERC721Full, ERC721Pausable {

    address creator;

    constructor(string ElectionName, string abrev, address _creator) public {
        ERC721Full(ElectionName, abrev);
        creator = _creator;
    }
}