import { ToEthereum } from "../web3/Utils";
const Masonry = artifacts.require("Masonry");

contract('Masonry', (accounts) => {
  it('should add a new member', async () => {
    const contractInstance = await Masonry.deployed();
    const initialInfluenceValue = parseInt(await contractInstance.GetTotalInfluence.call());
    var account = accounts[3];

    let addedValue = ToEthereum(1);
    const newAccountResponse = await contractInstance.JoinTheCause({ from: account, value: addedValue });
    console.log(newAccountResponse);
    console.log(contractInstance);
    console.log(contractInstance.address);
    const accountStatus = await contractInstance.GetMemberRank.call({ from: account });

    const alteredInfluenceValue = parseInt(await contractInstance.GetTotalInfluence.call());

    assert.equal(accountStatus, "Calfa", "Wrong new account rank");
    assert.equal(alteredInfluenceValue, initialInfluenceValue + addedValue, "The contract internal value did not change properly");
  });
});

function ToEthereum(desiredValue) {
  let wei = desiredValue * (10 ** 18);

  return wei
}