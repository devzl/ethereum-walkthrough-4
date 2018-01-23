pragma solidity ^0.4.18;

import './SafeMath.sol';

contract OurTutoCoin {
	using SafeMath for uint256;

	uint256 public totalSupply;

	string public name = "Our Tutorial Coin";
	string public symbol = "OTC";
	uint8 public decimals = 2;
}