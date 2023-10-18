// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/** Custom Errors **/
// User does not have minimum tokens to deposit
error balanceMinimum();
// User has already supplied an answer
error alreadyAnswered(); 
// Contract is not payable
error notPayable(); 

//notes:
// May be able to change uint256 -> uint8 for keeping track of specific answers
/**
 * @title SubDistributor
 * @author Daniel Kim (https://github.com/danielhyk1)
 * @notice Users pay AATTokens into this contract which
 * redistributes them after a set condition to the winners
 */
contract SubDistributor is Ownable {
    /* State Variables*/
    uint256 immutable public i_tokenAmount; // The minimum bid for each player
    address immutable i_AATToken;
    address[] public s_players;
    mapping(address => uint256) s_answers;

    constructor(address _token, uint256 _tokenAmount) {
        i_AATToken = _token;
        i_tokenAmount = _tokenAmount; 
    }

    /**
     * @dev Takes AAT from users and stores them in AAT contract
     * @param _amount Amount of AAT
     * @param _answer The answer selected
     */
    function deposit(uint256 _amount, uint256 _answer) public {
        if(IERC20(i_AATToken).balanceOf(msg.sender) < _amount) { // Checks minimum balance
            revert balanceMinimum(); 
        }
        if(amount[msg.sender] != 0) { // Checks to see if user has already answered
            revert alreadyAnswered(); 
        }
        IERC20(i_AATToken).transferFrom(msg.sender, address(this), _amount); 
        s_answers[msg.sender] = _answer; // record answer
        s_players.push(msg.sender);
    }


    /**
     * @dev Reditributes AAT based on single answer
     * @param _answer Off-chain single data answer
     */
    function distributeRewards(uint256 _answer) public /* internal */{
        address[] memory players = s_players;
        address[] memory winners = new address[](players.length);
        uint256 widx = 0;

        // Looks for winners
        for (uint256 i = 0; i < players.length; i++) {
            if (s_answers[players[i]] == _answer) {
                winners[widx++] = players[i]; // Can be gas optimized
            }
        }

        uint256 balance = getContractBalance();
        uint256 remainder = balance % widx; // Can burn or transfer remainder

        balance -= remainder; // Get evenly divisible balance
        balance /= widx; // Get value to distribute

        // Pays Winners
        for (uint256 i = 0; i < widx; i++) {
            IERC20(i_AATToken).transfer(winners[i], balance);
        }
    }
    
    function getPlayerAnswer() public view returns (uint256) {
        return s_answers[msg.sender]; 
    }

    function getContractBalance() public view returns (uint256) {
        return IERC20(i_AATToken).balanceOf(address(this));
    }

    recieve() external payable{
        revert notPayable(); 
    }
}
