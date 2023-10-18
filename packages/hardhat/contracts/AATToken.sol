// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error notValid();

/**
 * @title AAT Token
 * @author Daniel Kim (https://github.com/danielhyk1)
 * @notice Basic ERC20 Token - All token logic inside Distributor
 */
contract AATToken is ERC20, Ownable {
    mapping(address => uint8) validAddresses;

    constructor(uint256 initialSupply) ERC20("AATToken", "AAT") {
        _mint(msg.sender, initialSupply);
    }

    function sendToDistributor(uint256 amount) public onlyOwner {
        _mint(msg.sender, amount);
    }

    function addContracts(address addr) public onlyOwner {
        validAddresses[addr] = 1;
    }

    modifier checkContracts() {
        if (validAddresses[msg.sender] == 0) {
            revert notValid();
        }
        _;
    }
}
