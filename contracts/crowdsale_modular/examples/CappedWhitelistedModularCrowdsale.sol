pragma solidity ^0.4.18;

import "../validation/DateValidation.sol";
import "../validation/WeiCapValidation.sol";
import "../validation/NonZeroValidation.sol";
import "../validation/WhitelistValidation.sol";

contract CappedWhitelistedModularCrowdsale is 
				 DateValidation, 
				 NonZeroValidation, 
				 WeiCapValidation(1000 ether),
				 WhitelistValidation {}
