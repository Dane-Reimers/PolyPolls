pragma solidity ^0.5.16;

import './Election.sol';

contract ElectionManager {
    
    uint numElections = 0;
    mapping(string => Election) private electionsByName;
    mapping(uint => Election) private electionsById;
    mapping(string => bool) private electionExists;
    string[] private electionNames;
    

    constructor() public {
    }

    function createElection(string memory name) public {
        require(electionExists[name] == false, "Cannot reuse election name");
        
        Election newElection = new Election(name, msg.sender);
        electionsByName[name] = newElection;
        numElections += 1;
        electionsById[numElections] = newElection;
        electionNames.push(name);
        electionExists[name] = true;
    }
    
    function getNumElections() public view
        returns (uint)
    {
        return numElections;
    }
    
    function getElectionById(uint electionId) public view
        returns (Election)
    {
        return electionsById[electionId];
    }
    
    function getElectionByName(string memory name) public view
        returns (Election)
    {
        return electionsByName[name];
    }
}