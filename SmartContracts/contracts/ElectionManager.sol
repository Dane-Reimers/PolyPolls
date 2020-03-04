pragma solidity >=0.5.0;

import './Election.sol';

contract ElectionManager {

    uint numElections = 0;
    mapping(uint => Election) private elections;

    constructor() public {
    }

    function createElection(string memory name) public {
        Election newElection = new Election(name, msg.sender);
        numElections += 1;
        elections[numElections] = newElection;
    }
    
    function getNumElections() public view
        returns (uint)
    {
        return numElections;
    }
    
    function getElectionById(uint electionId) public view
        returns (Election)
    {
        return elections[electionId];
    }
}