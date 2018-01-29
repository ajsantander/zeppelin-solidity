pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract WeiCapValidation is ModularCrowdsale {
	
	uint256 totalRaisedCap;

	function WeiCapValidation(uint256 _cap) public {
		addValidation(validate);
	}

	function validate() view returns (bool) {
		return weiRaised.add(msg.value) <= totalRaisedCap;
	}
}
