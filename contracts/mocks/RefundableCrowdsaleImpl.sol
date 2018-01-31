pragma solidity ^0.4.18;


import "../crowdsale/distribution/RefundableCrowdsale.sol";
import "../crowdsale/distribution/MintedCrowdsale.sol";

contract RefundableCrowdsaleImpl is RefundableCrowdsale, MintedCrowdsale {

  function RefundableCrowdsaleImpl (
    uint256 _startTime,
    uint256 _endTime,
    uint256 _rate,
    address _wallet,
    uint256 _goal,
    MintableToken _token
  ) public
    CrowdsaleBase(_startTime, _endTime, _rate, _wallet)
    MintedCrowdsale(_token)
    RefundableCrowdsale(_goal)
  {
  }

}
