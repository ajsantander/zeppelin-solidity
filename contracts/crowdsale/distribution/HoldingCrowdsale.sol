pragma solidity ^0.4.18;

import "../CrowdsaleBase.sol";
import "../../token/ERC20/ERC20.sol";

contract HoldingCrowdsale is CrowdsaleBase {
  
  ERC20 public token;

  function HoldingCrowdsale(ERC20 _token) {
    require(_token != address(0));
    token = _token;
  }

  // TODO: consider querying balance left and end crowdsale if depleted 

  function processPurchase(address _beneficiary, uint256 _tokenAmount) internal {
    token.transfer(_beneficiary, _tokenAmount);
  }
}
