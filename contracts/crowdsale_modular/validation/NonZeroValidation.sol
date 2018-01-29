pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract NonZeroValidation is ModularCrowdsale {

	function NonZeroValidation() {
		addValidation(validate);
	}

	function validate() view returns (bool) {
		return msg.value > 0;
	}
}
