//initializations
const fs = require('fs');
const contractJson = JSON.parse(fs.readFileSync('./build/contracts/Masonry.json', 'utf8'));
const contractAbi = contractJson.abi;

var Web3 = require('web3');
var web3Provider = new Web3.providers.HttpProvider('http://localhost:7545')
var web3 = new Web3(web3Provider);
const { toHex } = web3.utils;
//end initializations

var contractAddress = '0x22C734a24E0d87BB426c1A5cc3398EDf232C56b1';
const contract = new web3.eth.Contract(contractAbi, contractAddress);

 SendJoinTheCause()
// CallMemberStatuses();
SendStealMoney();
CallGetTotalInfluence();

function CallMemberStatuses(){
    contract.methods.GetMemberInfluence().call({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', gas:5000000})
    .then((res) => {
        console.log('Your influence is: ' + res);
    })
    .catch(console.log)
    contract.methods.GetMemberRank().call({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', gas:5000000})
    .then((res) => {
        console.log('Your rank is: ' + res);
    })
    .catch(console.log)
}

function CallGetTotalInfluence(){
    contract.methods.GetTotalInfluence().call({from: '0xfB1aeBC7606Ed73f95D7713d1Af2BA0f9c834999', gas:5000000})
    .then((res) => {
        console.log('Your influence is: ' + res);
    })
    .catch(console.log)
}

function SendJoinTheCause(){
    contract.methods.JoinTheCause().send({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', value:ToEthereum(2), gas:5000000})
    .then((res) => {
        console.log(res);

        contract.methods.GetTotalInfluence().call()
        .then(console.log)
    })
    .catch(console.log)
}

function SendContributeToTheCause(){
    contract.methods.JoinTheCause().send({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', value:ToEthereum(2), gas:5000000})
    .then((res) => {
        console.log(res);

        contract.methods.GetTotalInfluence().call()
        .then(console.log)
    })
    .catch(console.log)
}

function SendStealMoney(){
    let desiredValue = ToEthereum(0.5);

    contract.methods.BreakPonziScheme(toHex(desiredValue)).send({from: '0xfB1aeBC7606Ed73f95D7713d1Af2BA0f9c834999', gas:5000000})
    .then((res) => {
        console.log(res);

        contract.methods.GetTotalInfluence().call()
        .then(console.log)
    })
    .catch(console.log)
}

function ToEthereum(desiredValue){
    let wei = desiredValue*(10**18);

    return wei
}