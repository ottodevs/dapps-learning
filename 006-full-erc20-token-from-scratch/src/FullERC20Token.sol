pragma solidity ^0.4.9;

import './erc20/src/erc20.sol';

contract FullERC20Token is ERC20 {

    uint private s_totalSupply;
	mapping(address => uint) private s_balances;


    function FullERC20Token(uint _totalSupply) {
        s_totalSupply = _totalSupply;
		s_balances[msg.sender] = _totalSupply;
    }

	function totalSupply() constant returns (uint supply) {
		return s_totalSupply;
	}

    function balanceOf( address _who ) constant returns (uint value) {
		return s_balances[_who];
	}

    function allowance( address owner, address spender ) constant returns (uint _allowance) {
		throw;	
	}

    function transfer( address to, uint value) returns (bool) {
		if (value > s_balances[msg.sender]) throw;				// balance check
		if (s_balances[to] > s_balances[to] + value) throw;		// overflow check

		s_balances[msg.sender] -= value;
		s_balances[to] += value;

		Transfer(msg.sender, to, value);

		return true;
	}

    function transferFrom( address from, address to, uint value) returns (bool ok) {
		throw;
	}

    function approve( address spender, uint value ) returns (bool ok) {
		throw;
	}

    event Transfer( address indexed from, address indexed to, uint value);
    event Approval( address indexed owner, address indexed spender, uint value);
}
