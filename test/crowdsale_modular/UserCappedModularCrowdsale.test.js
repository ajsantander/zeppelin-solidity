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

const UserCappedModularCrowdsale = artifacts.require('UserCappedModularCrowdsale');
const MintableToken = artifacts.require('MintableToken');

contract('UserCappedModularCrowdsale', function (accounts) {
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
    this.crowdsale = await UserCappedModularCrowdsale.new(this.startTime, this.endTime, rate, wallet, this.token.address);
    await this.token.transferOwnership(this.crowdsale.address);
  });

  describe('user caps', function () {
    const amount = ether(1)

    beforeEach(async function () {
      await increaseTimeTo(this.startTime);
    });

    it('should not impose a cap on a user if no cap was set for the user', async function() {
      await this.crowdsale.sendTransaction({value: ether(5), from: user});
    });

    it('should not allow a user to contribute more than the cap set for the user', async function() {
      await this.crowdsale.setUserCap(user, ether(10));
      await this.crowdsale.sendTransaction({value: ether(15), from: user}).should.be.rejectedWith(EVMRevert);
    });
  })
});
