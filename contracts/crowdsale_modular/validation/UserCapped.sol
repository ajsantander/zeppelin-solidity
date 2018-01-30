pragma solidity ^0.4.18;

import "../ModularCrowdsale.sol";

contract UserCapped is ModularCrowdsale {
	
	mapping(address => uint256) userCaps;

	function UserCapped() public {
		addValidation(validateUserCap);
	}

	function setUserCap(address _user, uint256 _cap) {
		userCaps[_user] = _cap;	
	}

  function validateUserCap() internal view returns (bool) {
    uint256 cap = userCaps[msg.sender];
    if(cap == 0) return true;
    uint256 contributed = contributions[msg.sender];
    return contributed.add(msg.value) <= cap;
	}
}
