pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract DateValidation is ModularCrowdsale {
	
	function DateValidation() {
		addValidation(validate);
	}

	function validate() view returns (bool) {
		return now >= startTime && now <= endTime;
	}
}
