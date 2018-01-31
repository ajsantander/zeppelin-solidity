pragma solidity ^0.4.18;


import "../crowdsale/validation/CappedCrowdsale.sol";
import "../crowdsale/distribution/MintedCrowdsale.sol";

contract CappedCrowdsaleImpl is CappedCrowdsale, MintedCrowdsale {

  function CappedCrowdsaleImpl (
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    address _wallet,
    uint256 _cap,
    MintableToken _token
  ) public
    CrowdsaleBase(_startTime, _endTime, _rate, _wallet)
    CappedCrowdsale(_cap)
    MintedCrowdsale(_token)
  {}
}
