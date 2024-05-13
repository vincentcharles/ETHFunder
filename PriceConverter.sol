// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// Library for converting ETH prices to USD
library PriceConverter {

    // Internal function to retrieve the price of ETH in USD
    function getPrice() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10); // Adjusting the price to have the correct decimal places
    }

    // Internal function to get the version of the price feed
    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    // Internal function to convert a given amount of ETH to its equivalent USD value
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice(); // Getting current ETH price in USD
        uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18; // Converting ETH amount to USD
        return ethAmountInUsd;
    }
}
