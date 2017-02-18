pragma solidity ^0.4.9;

import './erc20/src/erc20.sol';

contract FullERC20Token is ERC20 {

    uint256 _totalSupply;

    function totalSupply() constant returns (uint) {
        return _totalSupply;
    }

    function FullERC20Token(uint totalSupply) {
        _totalSupply = totalSupply;
    }


    // empty methods, only so it compiles and I can run tests
    function balanceOf( address who ) constant returns (uint value) { throw; }
    function allowance( address owner, address spender ) constant returns (uint _allowance) { throw; }

    function transfer( address to, uint value) returns (bool ok) { throw; }
    function transferFrom( address from, address to, uint value) returns (bool ok) { throw; }
    function approve( address spender, uint value ) returns (bool ok) { throw; }

    event Transfer( address indexed from, address indexed to, uint value);
    event Approval( address indexed owner, address indexed spender, uint value);
}
