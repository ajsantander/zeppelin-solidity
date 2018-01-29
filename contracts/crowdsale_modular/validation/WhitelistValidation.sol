pragma solidity ^0.4.19;

contract WhitelistValidation is Crowdsale {

	mapping(address => bool) whitelist;
	
	function WhitelistValidation() {
		addValidationCondition(validate);
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
