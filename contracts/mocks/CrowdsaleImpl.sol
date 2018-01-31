pragma solidity ^0.4.18;

import "../crowdsale/distribution/MintedCrowdsale.sol";
import "../token/ERC20/MintableToken.sol";

contract CrowdsaleImpl is MintedCrowdsale {

  function CrowdsaleImpl(
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    address _wallet,
    MintableToken _token
  ) public 
    CrowdsaleBase(_startTime, _endTime, _rate, _wallet)
    MintedCrowdsale(_token)
  {}
}
