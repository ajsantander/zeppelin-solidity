pragma solidity ^ 0.4.18;

import "./Crowdsale.sol";
import "../ownership/Ownable.sol";

contract WhitelistedCrowdsale is Crowdsale, Ownable {
  
  mapping(address => bool) public whitelist;

  function addToWhitelist(address beneficiary) external onlyOwner {
    whitelist[beneficiary] = true;
  }

  function removeFromWhitelist(address beneficiary) external onlyOwner {
    whitelist[beneficiary] = false;
  }

  function isWhitelisted(address beneficiary) public view returns (bool) {
    return whitelist[beneficiary];
  }

  function preValidatePurchase(address beneficiary, uint256 weiAmount) internal {
    super.preValidatePurchase(beneficiary, weiAmount);
    require(isWhitelisted(beneficiary));
  }
}
