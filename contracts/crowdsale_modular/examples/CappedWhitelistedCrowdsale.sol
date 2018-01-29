pragma solidity ^0.4.19;

contract CappedWhitelistedCrowdsale is 
				 DateValidation, 
				 WeiCapValidation(1000 ether),
				 NonZeroValidation {

	function CappedWhitelistCrowdsale() {
		
	}
}
