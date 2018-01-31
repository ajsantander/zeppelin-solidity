pragma solidity ^0.4.18;

import "../Crowdsale.sol";
import "../../token/ERC20/MintableToken.sol";

contract MintedCrowdsale is Crowdsale {
  
  function MintedCrowdsale(MintableToken _token) {
    require(_token != address(0));
  }

  function distributeTokens(address beneficiary, uint256 tokenAmount) internal {
    _token.mint(beneficiary, tokenAmount);
  }
}
