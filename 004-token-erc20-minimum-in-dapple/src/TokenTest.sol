pragma solidity ^0.4.9;

import 'dapple/test.sol';
import './Token.sol';

contract TokenTest is Test {
    Token token = new Token(100, "Test Token", 16, "TTK");
    Tester user1;
    Tester user2;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() {
        user1 = new Tester();
        user1._target(token);

        user2 = new Tester();
        user2._target(token);
    }

    function testDecimalsArePreserved() {
        assertTrue( token.decimals() == uint8(16) );
    }

    function testInitialSupplyBelongsToTheCreator() {
        assertEq( token.balanceOf(address(this)), 100 );
    }

    function testBalanceOfOtherAddressesIsEmpty() {
        assertEq( token.balanceOf(address(user1)), 0 );
        assertEq( token.balanceOf(address(user2)), 0 );
    }

    function testPartialTransferToSomeOtherAddress() {
        token.transfer( address(user1), 40 );

        assertEq( token.balanceOf(address(this)), 60 );
        assertEq( token.balanceOf(address(user1)), 40 );
    }

    function testCompleteTransferToSomeOtherAddress() {
        token.transfer( address(user1), 100 );

        assertEq( token.balanceOf(address(this)), 0 );
        assertEq( token.balanceOf(address(user1)), 100 );
    }

    function testManyTransfersBetweenAddresses() {
        // this -> user1
        token.transfer( address(user1), 10 );
        token.transfer( address(user1), 30 );
        
        // user1 -> user2
        Token(user1).transfer( address(user2), 15 );
        
        // user2 -> this
        Token(user2).transfer( address(this), 7 );

        assertEq( token.balanceOf(address(this)), 67 );
        assertEq( token.balanceOf(address(user1)), 25 );
        assertEq( token.balanceOf(address(user2)), 8 );
    }

    function testEmittingTheTransferEvent() {
        expectEventsExact( token );
        Transfer( address(this), address(user1), 35 );

        token.transfer( address(user1), 35 );
    }

    function testFailsToSendMoreThanTheBalance() {
        token.transfer( address(user1), 101 );
    }

    // would be nice to have a test for overflow as well
}
