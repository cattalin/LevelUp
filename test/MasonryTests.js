const Masonry = artifacts.require("Masonry");

contract('Masonry', (accounts) => {
  it('should retrieve the initial internal total value of the contract', async () => {
    const contractInstance = await Masonry.deployed();
    const result = await contractInstance.GetTotalInfluence.call();

    assert.equal(result.valueOf(), 0, "the freshly deployed contract had a wrong default influence level");
  });

  it('should add a new member', async () => {
    const contractInstance = await Masonry.deployed();
    const initialInfluenceValue = (await contractInstance.GetTotalInfluence.call()).valueOf();
    
    let addedValue = ToEthereum(1);
    const newAccountResponse = await contractInstance.JoinTheCause.send({from: accounts[1], value: addedValue});
    const accountStatus = await contractInstance.GetMemberRank.call({from: accounts[1]});

    const alteredInfluenceValue = (await contractInstance.GetTotalInfluence.call()).valueOf();

    assert.equal(accountStatus, "Calfa", "Wrong new account rank");
    assert.equal(alteredInfluenceValue, initialInfluenceValue + addedValue, "The contract internal value did not change properly");
  });

  it('should test something', async () => {
    const contractInstance = await Masonry.deployed();
    const initialInfluenceValue = (await contractInstance.GetTotalInfluence.call()).valueOf();
    
    //test logic here
    let addedValue = ToEthereum(0);

    //test logic until here

    const alteredInfluenceValue = (await contractInstance.GetTotalInfluence.call()).valueOf();

    assert.equal(alteredInfluenceValue, initialInfluenceValue + addedValue, "The contract internal value did not change properly");
  });
});

function ToEthereum(desiredValue){
  let wei = desiredValue*(10**18);

  return wei
}