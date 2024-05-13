# ETHFunder
EthFunder: A Solidity smart contract on Ethereum for crowdfunding with ETH. It features minimum USD contributions, owner-only withdrawals, and uses Chainlink for real-time ETH pricing. Based on @cyfrin Solidity course.

# FundMe Contract

## Overview
The `FundMe` contract allows users to send ETH to it and keep track of each contributor's total contribution. The contract enforces a minimum contribution amount in USD and allows only the owner to withdraw the accumulated ETH.

## Features
- **Fund**: Users can fund the contract with ETH above a specified USD threshold.
- **Withdraw**: Allows the owner to withdraw all the funds from the contract.
- **Owner Restrictions**: Only the owner can perform critical operations like withdrawing funds.

## Contracts
- **FundMe.sol**: Main contract allowing funding and withdrawal.
- **PriceConverter.sol**: Library used by FundMe to handle price conversions between ETH and USD.

## Usage
1. **Setup**: Deploy `FundMe` which will automatically set the deployer as the owner.
2. **Funding**: Send ETH to the contract using the `fund` function or by sending ETH directly.
3. **Withdraw**: Owner can withdraw funds using the `withdraw` function.

## Technologies
- Solidity
- Chainlink (for ETH price data)

## Setup
Deploy the contracts using your preferred Solidity development environment, such as Remix, Truffle, or Hardhat.

## License
This project is licensed under the MIT License.
