pragma solidity ^0.4.18;

    /**
     * @title SafeMath
     * @dev Math operations with safety checks that throw on error
     * @notice source: https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/math/SafeMath.sol
     */

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

	/**
	 * @title OurTutoCoin
	 * @dev A one file ERC20 token for the 4th part of the Ethereum Development Walkthrough tutorial series
	 * 
	 * @notice check https://github.com/OpenZeppelin/zeppelin-solidity for a better, modular code
	*/

contract OurTutoCoin {
	using SafeMath for uint256; // SafeMath methods will be available for the type "unit256"

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

	/**
	   * @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender.
	   *
	   * Beware that changing an allowance with this method brings the risk that someone may use both the old
	   * and the new allowance by unfortunate transaction ordering. One possible solution to mitigate this
	   * race condition is to first reduce the spender's allowance to 0 and set the desired value afterwards:
	   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
	   * @param _spender The address which will spend the funds.
	   * @param _value The amount of tokens to be spent.
	   */
	function approve(address _spender, uint256 _value) public returns (bool) {
		allowed[msg.sender][_spender] = _value;
		Approval(msg.sender, _spender, _value);
		return true;
	}

	/**
	* @dev Transfer tokens from one address to another
	* @param _from address The address which you want to send tokens from
	* @param _to address The address which you want to transfer to
	* @param _value uint256 the amount of tokens to be transferred
	*/
	function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
		require(_to != address(0));
		require(_value <= balances[_from]);
		require(_value <= allowed[_from][msg.sender]);

		balances[_from] = balances[_from].sub(_value);
		balances[_to] = balances[_to].add(_value);
		allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
		Transfer(_from, _to, _value);
		return true;
	}


	/**
	* @dev Allows the current owner to transfer control of the contract to a newOwner.
	* @param newOwner The address to transfer ownership to.
	*/
	function transferOwnership(address newOwner) public onlyOwner {
		require(newOwner != address(0));
		OwnershipTransferred(owner, newOwner);
		owner = newOwner;
	}

	function mint(address _to, uint256 _amount) onlyOwner public returns (bool) {
		totalSupply = totalSupply.add(_amount);
		balances[_to] = balances[_to].add(_amount);
		Mint(_to, _amount);
		Transfer(address(0), _to, _amount);
		return true;
	}
}