pragma solidity ^0.4.18;

import "../validation/Capped.sol";
import "../validation/Whitelisted.sol";

contract WhitelistedModularCrowdsale is 
				 Whitelisted {
         
  function WhitelistedModularCrowdsale(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    address _wallet,
    MintableToken _token
  ) public
  ModularCrowdsale(_startTime, _endTime, _rate, _wallet, _token)
  Whitelisted() {}
}
