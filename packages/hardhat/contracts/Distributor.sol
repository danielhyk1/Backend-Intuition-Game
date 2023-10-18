// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "./AATToken.sol";
import "./SubDistributor.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Distributor
 * @author Daniel Kim (https://github.com/danielhyk1)
 * @notice Users pay AATTokens into this contract which
 * redistributes them after a set condition to the winners
 */
contract Distributor is Ownable {
    AATToken immutable i_AATToken;
    /* State Variables */
    address[] public s_subDistributors;

    constructor(uint256 _initialSupply) {
        i_AATToken = new AATToken(_initialSupply);
    }

    /**
     * @dev Creates a new sub contract of type SubDistributor
     */
    function newSubDistributor() internal onlyOwner {
        SubDistributor subDistributor = new SubDistributor(address(i_AATToken));
        s_subDistributors.push(address(subDistributor));
    }

    function mint(uint256 amount) public onlyOwner {
        i_AATToken.sendToDistributor(amount);
    }

    function transfer(address _to, uint256 _amount) public /*fix - internal onlyOwner */{
        IERC20(i_AATToken).transfer(_to, _amount);
    }

    function getTokenAddress() external view returns (address) {
        return address(i_AATToken);
    }

    function checkBalance(address _address) public view returns (uint256) {
        return IERC20(i_AATToken).balanceOf(_address); 
    }

    function totalBalance() public view returns (uint256) {
        return IERC20(i_AATToken).balanceOf(address(this));
    }

    function getSubDistributorsLength() public view returns (uint256) {
        return s_subDistributors.length;
    }
}
