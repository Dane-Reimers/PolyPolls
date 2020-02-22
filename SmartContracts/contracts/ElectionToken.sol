pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Burnable.sol";


contract ElectionToken is ERC721Full, ERC721Pausable, ERC721Burnable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    constructor(string memory _electionName, string memory _electionAbrev)
    ERC721Full(_electionName, _electionAbrev) public {
    }

    // Creates a 721 token for the creator of the election
    // Uses the election name to fill the token URI, in order to
    // Authenticate a real voter
    function mintVote(address voter, string memory electionName)
        public returns (unit256) {
        
        _tokenIds.increment();

        uint256 voteID = _tokenIds.current();
        _mint(voter, tokenID);
        _setTokenURI(voteID, electionName);

        return voteID;
    }
}