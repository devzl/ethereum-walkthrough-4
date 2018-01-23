pragma solidity ^0.4.18;

import './SafeMath.sol';

contract OurTutoCoin {
	using SafeMath for uint256;

	uint256 public totalSupply;

	string public name = "Our Tutorial Coin";
	string public symbol = "OTC";
	uint8 public decimals = 2;

	mapping(address => uint256) balances;
	mapping (address => mapping (address => uint256)) internal allowed;

	address public owner;

	event Transfer(address indexed from, address indexed to, uint256 value);
	event Approval(address indexed owner, address indexed spender, uint256 value);
	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
	event Mint(address indexed to, uint256 amount);

	/**
	* @dev Throws if called by any account other than the owner.
	*/
	modifier onlyOwner() {
		require(msg.sender == owner);
		_;
	}

	/**
	* @dev The OurTutoCoin constructor sets the original `owner` of the contract to the sender
	* account.
	*/
	function OurTutoCoin() public {
		owner = msg.sender;
	}

	function totalSupply() public constant returns (uint256 _totalSupply) {
		return totalSupply;
	}



}