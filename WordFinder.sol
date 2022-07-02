//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WordFinder {
    string private theWord;
    mapping(address => bool) blacklistedAddresses;

    constructor(string memory newWord) payable {
        theWord = newWord;
    }

    function addToBlackList(address newAddress) public {
        blacklistedAddresses[newAddress] = true;
    }

    function findWord(string memory newWord) public{
        require(blacklistedAddresses[msg.sender] == false, "You are in the Blacklist");
        if (keccak256(abi.encodePacked(theWord)) == keccak256(abi.encodePacked(newWord))) {
            uint256 prizeAmount = 0.001 ether;
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
            addToBlackList(msg.sender);
            console.log('succes');
        }
        else {
            console.log('Try again');
        }
    }

}
