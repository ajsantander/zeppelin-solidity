pragma solidity ^0.4.19;

import "../Crowdsale";

contract NonZeroValidation is Crowdsale {

	function NonZeroValidation() {
		addValidationCondition(validate);
	}

	function validate() view returns (bool) {
		return msg.value > 0;
	}
}
