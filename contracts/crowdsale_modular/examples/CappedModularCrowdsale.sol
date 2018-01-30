pragma solidity ^0.4.18;

import "../validation/Capped.sol";

contract CappedModularCrowdsale is 
				 Capped {
         
  function CappedModularCrowdsale(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    address _wallet,
    uint256 _cap,
    MintableToken _token
  ) public
  ModularCrowdsale(_startTime, _endTime, _rate, _wallet, _token)
  Capped(_cap) {}
}
