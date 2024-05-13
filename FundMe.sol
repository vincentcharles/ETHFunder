// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol"; // Importing the PriceConverter library

error NotOwner(); // Custom error for unauthorized actions

// The FundMe contract enables funding in ETH and handles withdrawals.
contract FundMe {
    using PriceConverter for uint256; // Using the library for uint256 type

    address[] public funders; // List of addresses that have funded the contract
    mapping(address => uint256) public addressToAmountFunded; // Maps each funder to the amount they have funded

    address public immutable i_owner; // Owner of the contract
    uint256 public constant MIN_USD = 5e18; // Minimum amount in USD required to fund

    constructor() {
        i_owner = msg.sender; // Setting the owner of the contract to the creator
    }

    // Function to accept ETH and track the funding per address
    function fund() public payable {
        require(msg.value.getConversionRate() >= MIN_USD, "You didn't send enough ETH!"); // Checking if the sent ETH is above the minimum
        addressToAmountFunded[msg.sender] += msg.value; // Updating the funding amount
        funders.push(msg.sender); // Adding sender to funders list
    }

    // Function to withdraw all funds from the contract, only callable by the owner
    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0; // Resetting funded amount for each funder
        }
        funders = new address[](0) ; // Resetting the funders array
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed"); // Ensuring that the withdrawal was successful
    }

    // Modifier to restrict certain actions to only the owner of the contract
    modifier onlyOwner() {
        if(msg.sender != i_owner) {revert NotOwner();}
        _; 
    } 

    // Special function to handle direct ETH transfers without data
    receive() external payable { 
        fund();
    }

    // Fallback function to handle incoming calls or transactions that do not match any other function
    fallback() external payable { 
        fund();
    }
}
