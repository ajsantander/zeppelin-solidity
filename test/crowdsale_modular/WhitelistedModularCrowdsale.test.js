import ether from '../helpers/ether';
import { advanceBlock } from '../helpers/advanceToBlock';
import { increaseTimeTo, duration } from '../helpers/increaseTime';
import latestTime from '../helpers/latestTime';
import EVMRevert from '../helpers/EVMRevert';

const BigNumber = web3.BigNumber;

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

const WhitelistedModularCrowdsale = artifacts.require('WhitelistedModularCrowdsale');
const MintableToken = artifacts.require('MintableToken');

contract('WhitelistedModularCrowdsale', function (accounts) {
  const rate = new BigNumber(1000);

  const [
    owner,
    wallet,
    user,
    ...users
  ] = accounts;
  
  before(async function () {
    // Advance to the next block to correctly read time in the solidity "now" function interpreted by testrpc
    await advanceBlock();
  });

  beforeEach(async function () {
    this.startTime = latestTime() + duration.weeks(1);
    this.endTime = this.startTime + duration.weeks(1);

    this.token = await MintableToken.new();
    this.crowdsale = await WhitelistedModularCrowdsale.new(this.startTime, this.endTime, rate, wallet, this.token.address);
    await this.token.transferOwnership(this.crowdsale.address);
  });

  describe('whitelisting', function () {
    const amount = ether(1)

    beforeEach(async function () {
      await increaseTimeTo(this.startTime);
    });

    it('should add address to whitelist', async function () {
      let whitelisted = await this.crowdsale.isWhitelisted(user)
      whitelisted.should.equal(false)
      await this.crowdsale.addToWhitelist(user, {from: owner})
      whitelisted = await this.crowdsale.isWhitelisted(user)
      whitelisted.should.equal(true)
    })

    it('should reject non-whitelisted user', async function () {
      await this.crowdsale.buyTokens(users[0], {value: amount, from: users[0]}).should.be.rejectedWith(EVMRevert)
    })

    it('should sell to whitelisted address', async function () {
      await this.crowdsale.addToWhitelist(user, {from: owner})
      await this.crowdsale.buyTokens(user, {value: amount, from:user}).should.be.fulfilled
    })
  })
});
