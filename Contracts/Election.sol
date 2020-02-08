pragma solidity ^0.5.16;

contract Election {
    
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    string name;
    address creator;
    
    // Mapping from hash of voter key to hash of voter value
    mapping(bytes32 => bytes32) validVoters;
    // Mapping from hash of voter key to bool voted
    mapping(bytes32 => bool) voted;
    
    uint candidatesCount;
    mapping(uint => Candidate) candidates;
    mapping(string => bool) candidateExists;

    constructor(string memory _name, address _creator) public {
        name = _name;
        creator = _creator;
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
    
    function addVoter(bytes32 voterKeyHash, bytes32 voterValueHash) public {
        require(msg.sender == creator, "Only the creator can add valid voters.");
        require(validVoters[voterKeyHash] == 0, "This voter can already vote.");
        validVoters[voterKeyHash] = voterValueHash;
    }

    function vote(uint candidateId, bytes32 voterKeyHash, bytes32 voterValueHash) public {
        require(validVoters[voterKeyHash] == voterValueHash, "Must be a valid voter.");
        require(!voted[voterKeyHash], "Cannot have already voted.");
        require((candidateId > 0) && (candidateId <= candidatesCount),
            "Must vote for valid candidate");

        voted[voterKeyHash] = true;
        candidates[candidateId].voteCount++;
        emit votedEvent(candidateId);
    }
}