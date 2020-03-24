import { web3 } from "./Infrastructure";

web3.eth.sendTransaction({
    from: '0xfB1aeBC7606Ed73f95D7713d1Af2BA0f9c834999',
    to: '0x03E610C02e2dA201d67daee523181235b2Ec7328',
    value: (10 ** 18).toString()
})
    .then(function (receipt) {
        console.log('received receipt');
        console.log(receipt);
    })
    .catch(function (error) {
        console.log('error caught');
        console.log(error);
    });
