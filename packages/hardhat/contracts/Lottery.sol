// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

/**
 * @title Distributor
 * @author Daniel Kim (https://github.com/danielhyk1)
 * @notice Free AAT to distribute to new users
 */
contract Lottery {
    /* State Variables */
    address immutable i_AATToken;
    mapping(address => uint256) newUsers;

    constructor(address _token) {
        i_AATToken = _token;
    }

    function requestTokens() external newUser {}

    modifier newUser() {
        require(newUsers[msg.sender] == 0);
        _;
    }
}
