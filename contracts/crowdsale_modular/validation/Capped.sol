pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract Capped is ModularCrowdsale {
	
	uint256 weiCap;

	function Capped(uint256 _cap) public {
    require(_cap > 0);
    weiCap = _cap;
		addValidation(validateWeiRaised);
    addFinalization(finalizeCapReached);
	}

  function finalizeCapReached() internal view returns (bool) {
    return weiRaised >= weiCap;
  }
	
  function validateWeiRaised() internal view returns (bool) {
		return weiRaised.add(msg.value) <= weiCap;
	}
}
