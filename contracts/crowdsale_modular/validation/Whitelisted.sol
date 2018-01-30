pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract Whitelisted is ModularCrowdsale {

	mapping(address => bool) whitelist;
	
	function Whitelisted() {
		addValidation(validateWhitelisted);
	}

  // TODO: protect
	function addToWhitelist(address user) {
		whitelist[user] = true;	
	}

  // TODO: protect
	function removeFromWhitelist(address user) {
		whitelist[user] = false;	
	}

  function isWhitelisted(address user) public view returns (bool) {
    return whitelist[user];
  }

	function validateWhitelisted() internal view returns (bool) {
		return whitelist[msg.sender] == true;
	}
}
