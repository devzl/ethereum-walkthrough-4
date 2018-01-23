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

	/**
	* @dev Gets the balance of the specified address.
	* @param tokenOwner The address to query the the balance of.
	* @return An uint256 representing the amount owned by the passed address.
	*/
	function balanceOf(address tokenOwner) public view returns (uint256 balance) {
		 return balances[tokenOwner];
	}	

	/**
	* @dev Function to check the amount of tokens that an owner allowed to a spender.
	* @param _owner address The address which owns the funds.
	* @param _spender address The address which will spend the funds.
	* @return A uint256 specifying the amount of tokens still available for the spender.
	*/
	function allowance(address _owner, address _spender) public view returns (uint256) {
		return allowed[_owner][_spender];
	}

	/**
	* @dev transfer token for a specified address
	* @param _to The address to transfer to.
	* @param _value The amount to be transferred.
	*/
	function transfer(address _to, uint256 _value) public returns (bool) {
		require(_to != address(0));
		require(_value <= balances[msg.sender]);

		// SafeMath.sub will throw if there is not enough balance.
		balances[msg.sender] = balances[msg.sender].sub(_value);
		balances[_to] = balances[_to].add(_value);
		Transfer(msg.sender, _to, _value);
		return true;
	}



}