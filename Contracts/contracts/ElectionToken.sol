pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";

contract ElectionToken is ERC721Full, ERC721Pausable {


    constructor(string ElectionName, string abrev) public {
        ERC721Full(ElectionName, abrev);
    }
}