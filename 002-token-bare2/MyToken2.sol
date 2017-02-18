pragma solidity 0.4.8;

contract MyToken2 {
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;

    function MyToken2(uint256 initialSupply) {
        balanceOf[msg.sender] = initialSupply;
    }
}

