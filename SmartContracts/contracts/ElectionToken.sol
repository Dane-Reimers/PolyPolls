pragma solidity >=0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Burnable.sol";

contract ElectionToken is ERC721Full, ERC721Pausable, ERC721Burnable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string electionName;

    constructor(string memory _electionName, string memory _electionAbrev)
    ERC721Full(_electionName, _electionAbrev) public {
        electionName = _electionName;
    }

    // Creates a 721 token for the creator of the election
    // Uses the election name to fill the token URI, in order to
    // Authenticate a real voter
    function mintVote(address voter)
        public returns (uint256) {
        
        _tokenIds.increment();

        uint256 voteID = _tokenIds.current();
        _mint(voter, voteID);
        _setTokenURI(voteID, electionName);

        return voteID;
    }
}