pragma solidity >=0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import "./ElectionToken.sol";

contract Election is IERC721Receiver {
    
    struct Candidate {
        uint id;
        string name;
     
        uint voteCount;
    }
    
    string name;
    address creator;
    
    // Records who has been added as a voter to prevent duplicate adds
    mapping(address => bool) voters;
    
    ElectionToken voteToken;
    uint candidatesCount;
    address[] voterAddresses;
    mapping(uint => Candidate) candidates;
    mapping(string => bool) candidateExists;

    constructor(string memory _name, address _creator) public {
        name = _name;
        creator = _creator;
        voteToken = new ElectionToken(_name, "VT");
    }

    event votedEvent(uint indexed candidateId);

    function addCandidate(string memory candidateName) public {
        require(msg.sender == creator, "Only the creator can add candidates.");
        require(!candidateExists[candidateName], "Cannot add an existing candidate.");
        
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, candidateName, 0);
        candidateExists[candidateName] = true;
    }
    
    function getNumCandidates() public view
        returns (uint)
    {
        return candidatesCount;
    }
 
    function getCandidate(uint id) public view
        returns (uint, string memory, uint)
    {
        return (id, candidates[id].name, candidates[id].voteCount);
    }

    function addVoters(address[] memory newVoters) public {
        for (uint i = 0; i < newVoters.length; i++) {
            addVoter(newVoters[i]);
        }
    }
    
    function addVoter(address voter) public 
    {
        require(msg.sender == creator, "Only the creator can add valid voters.");
        require(voters[voter] == false, "This voter can already vote.");
        voters[voter] = true;
        voteToken.mintVote(voter);

    }

    function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data)
        public returns (bytes4)
    {
        uint candidateId = bytesToUint(data);
        vote(candidateId, tokenId);
    }

    function vote(uint candidateId, uint256 tokenId) public 
    {
        require((candidateId > 0) && (candidateId <= candidatesCount),
            "Must vote for valid candidate");

        candidates[candidateId].voteCount++;
        voteToken.burn(tokenId);
        emit votedEvent(candidateId);
    }
    
    function bytesToUint(bytes memory b) internal pure 
    returns (uint256)
    {
        uint256 number;
        for(uint i = 0; i < b.length; i++){
            number = number + uint8(b[i])*(2**(8*(b.length-(i+1))));
        }
        return number;
    }

}