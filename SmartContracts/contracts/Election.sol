pragma solidity >=0.5.0;

contract Election {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
    
    string name;
    address creator;
    
    // Records who has been added as a voter to prevent duplicate adds
    mapping(address => bool) voters;
    
    uint candidatesCount;
    address[] voterAddresses;
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
    
    function addVoter(address voter) public {
        require(msg.sender == creator, "Only the creator can add valid voters.");
        require(voters[voter] == false, "This voter can already vote.");
        voters[voter] = true;
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