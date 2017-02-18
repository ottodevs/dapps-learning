pragma solidity ^0.4.9;

import 'dapple/test.sol';
import './Token.sol';

contract TokenTest is Test {

    function testNameSymbolsAndDecimalsPreserved() {
        Token token = new Token(100, "Test Token", 16, "TTK");
        token.transfer( address(this), 50 );

        string name = token.name;
        assertEq( name, "Test Token" );
        assertEq( token.decimals, 16 );
    }
}
