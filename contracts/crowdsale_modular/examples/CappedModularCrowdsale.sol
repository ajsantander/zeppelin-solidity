pragma solidity ^0.4.18;

import "../validation/DateValidation.sol";
import "../validation/WeiCapValidation.sol";
import "../validation/NonZeroValidation.sol";

contract CappedModularCrowdsale is 
				 DateValidation, 
         NonZeroValidation,
				 WeiCapValidation(1000 ether) {}
