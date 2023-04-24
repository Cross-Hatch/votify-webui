// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Votify {
    // Struct
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Keeps track that an address voted
    mapping(address => bool) public voters;
    // Keeps track of candidates
    mapping(uint256 => Candidate) public candidates;
    // Keeps track of candidates to compare ids
    uint256 public candidatesCount;

    // voted event
    event votedEvent (
        uint256 indexed _candidateId
    );

    constructor () {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint256 _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender], "This address has already voted.");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID.");

        // record that candidate has voted
        voters[msg.sender] = true;

        // update candidate vote counter
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}