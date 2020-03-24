import { ToEthereum } from "../jsUtils/ethUtils";
const Masonry = artifacts.require("Masonry");


contract('Masonry', (accounts) => {
    it('should retrieve the initial internal total value of the contract', async () => {
        const contractInstance = await Masonry.deployed();
        const result = parseInt(await contractInstance.GetTotalInfluence.call());

        assert.equal(result, 0, "The freshly deployed contract had a wrong default influence level");
    });

    it('should test something', async () => {
        const contractInstance = await Masonry.deployed();
        const initialInfluenceValue = parseFloat(await contractInstance.GetTotalInfluence.call());

        //test logic here
        let addedValue = ToEthereum(0);

        //test logic until here

        const alteredInfluenceValue = parseFloat(await contractInstance.GetTotalInfluence.call());

        assert.equal(alteredInfluenceValue, initialInfluenceValue + addedValue, "The contract internal value did not change properly");
    });
});
