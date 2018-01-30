pragma solidity ^0.4.18;

import "../token/ERC20/MintableToken.sol";
import "../math/SafeMath.sol";

contract ModularCrowdsale {

  using SafeMath for uint256;

  // The token being sold
  MintableToken public token;

  // start and end timestamps where investments are allowed (both inclusive)
  uint256 public startTime;
  uint256 public endTime;

  // address where funds are collected
  address public wallet;

  // how many token units a buyer gets per wei
  uint256 public rate;

  // amount of raised money in wei
  uint256 public weiRaised;

	mapping(address => uint256) contributions;

  /**
   * event for token purchase logging
   * @param purchaser who paid for the tokens
   * @param beneficiary who got the tokens
   * @param value weis paid for purchase
   * @param amount amount of tokens purchased
   */
  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);


  function ModularCrowdsale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet, MintableToken _token) public {
    require(_startTime >= now);
    require(_endTime >= _startTime);
    require(_rate > 0);
    require(_wallet != address(0));
    require(_token != address(0));

    startTime = _startTime;
    endTime = _endTime;
    rate = _rate;
    wallet = _wallet;
    token = _token;
  }

  // fallback function can be used to buy tokens
  function () external payable {
    buyTokens(msg.sender);
  }

  // low level token purchase function
  function buyTokens(address beneficiary) public payable {
    require(beneficiary != address(0));
    require(validPurchase());

    uint256 weiAmount = msg.value;

    // calculate token amount to be created
    uint256 tokens = getTokenAmount(weiAmount);

    // update state
    weiRaised = weiRaised.add(weiAmount);
    token.mint(beneficiary, tokens);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    // register contribution
    contributions[msg.sender] = contributions[msg.sender].add(weiAmount);

    forwardFunds();
  }

  // ----------------------------------------------------------------
  // Finalization module
  // Module that determines when a crowdsale has finished.
  // ----------------------------------------------------------------

  function() view returns (bool)[] finalizations;

  function addFinalization(function() view returns (bool) finalization) internal {
    finalizations.push(finalization);
  }

  // @return true if crowdsale event has ended
  function hasEnded() public view returns (bool) {
    if(now > endTime) return true;
    for(uint i = 0; i < finalizations.length; i++) {
      if(finalizations[i]()) return true;
    }
    return false;
  }

  // ----------------------------------------------------------------
  // Pricing module
  // Module that determines how ETH is converted to token amounts.
  // ----------------------------------------------------------------

  // Override this method to have a way to add business logic to your crowdsale when buying
  function getTokenAmount(uint256 weiAmount) internal view returns(uint256) {
    return weiAmount.mul(rate);
  }

  // ----------------------------------------------------------------
  // Fund distribution module
  // Module that determines how raised funds are managed.
  // ----------------------------------------------------------------

  // send ether to the fund collection wallet
  // override to create custom fund forwarding mechanisms
  function forwardFunds() internal {
    wallet.transfer(msg.value);
  }

  // ----------------------------------------------------------------
  // Token distribution module
  // Module that determines how the tokens of a purchase are 
  // distributed to the users.
  // ----------------------------------------------------------------

  // TODO

  // ----------------------------------------------------------------
  // Validation module
  // Module that determines wether a purchase is authorized.
  // ----------------------------------------------------------------

  function() view returns (bool)[] validations;

  function addValidation(function() view returns (bool) validation) internal {
    validations.push(validation);
  }

  // @return true if the transaction can buy tokens
  function validPurchase() internal view returns (bool) {
    if(now < startTime || now > endTime) return false;
    if(msg.value <= 0) return false;
    for(uint i = 0; i < validations.length; i++) {
      if(!validations[i]()) return false;
    }
    return true;
  }
}
