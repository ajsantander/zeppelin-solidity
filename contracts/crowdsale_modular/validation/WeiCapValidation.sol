pragma solidity ^0.4.19;

import "../Crowdsale";

contract WeiCapValidation is Crowdsale {
	
	uint256 totalRaisedCap;

	function WeiCapValidation(uint256 _cap) public {
		addValidationCondition(validate);
	}

	function validate() view returns (bool) {
		return weiRaised.add(msg.value) <= totalRaisedCap;
	}
}
