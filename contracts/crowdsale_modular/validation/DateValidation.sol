pragma solidity ^0.4.19;

import "../Crowdsale";

contract DateValidation is Crowdsale {
	
	function DateValidation() {
		addValidationCondition(validate);
	}

	function validate() view returns (bool) {
		return now >= startTime && now <= endTime;
	}
}
