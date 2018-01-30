pragma solidity ^0.4.18;

import "../math/SafeMath.sol";
import "./Crowdsale.sol";


/**
 * @title CappedCrowdsale
 * @dev Extension of Crowdsale with a max amount of funds raised
 */
contract CappedCrowdsale is Crowdsale {
  using SafeMath for uint256;

  uint256 public cap;

  function CappedCrowdsale(uint256 _cap) public {
    require(_cap > 0);
    cap = _cap;
  }

  // overriding Crowdsale#hasEnded to add cap logic
  // @return true if crowdsale event has ended
  function hasEnded() public view returns (bool) {
    bool capReached = weiRaised >= cap;
    return capReached || super.hasEnded();
  }

  // overriding Crowdsale#validPurchase to add extra cap logic
  // @return true if investors can buy at the moment
  // function validPurchase() internal view returns (bool) {
  //   bool withinCap = weiRaised.add(msg.value) <= cap;
  //   return withinCap && super.validPurchase();
  // }

  function postValidatePurchase(address _beneficiary, uint256 _weiAmount) internal {
    super.postValidatePurchase(_beneficiary, _weiAmount);
    require(weiRaised <= cap);
  }

}
