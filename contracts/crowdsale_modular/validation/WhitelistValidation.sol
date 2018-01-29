pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract WhitelistValidation is ModularCrowdsale {

	mapping(address => bool) whitelist;
	
	function WhitelistValidation() {
		addValidation(validate);
	}

	function addToWhitelist(address user) {
		whitelist[user] = true;	
	}

	function removeFromWhitelist(address user) {
		whitelist[user] = false;	
	}

	function validate() view returns (bool) {
		return whitelist[msg.sender] == true;
	}
}
