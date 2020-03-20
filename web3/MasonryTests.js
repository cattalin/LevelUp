//fucking initializations
const fs = require('fs');
const contractJson = JSON.parse(fs.readFileSync('./build/contracts/Masonry.json', 'utf8'));
const contractAbi = contractJson.abi;

var Web3 = require('web3');
var web3Provider = new Web3.providers.HttpProvider('http://localhost:7545')
var web3 = new Web3(web3Provider);
//end fucking initializations

var contractAddress = '0xc9f0a80f0E4efea9197B1a9Dca29a0d10393d2f4';
const contract = new web3.eth.Contract(contractAbi, contractAddress);
// contract.defaultAccount = '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC'; merge o pula

CallMemberStatuses();

function CallMemberStatuses(){
    contract.methods.GetMemberInfluence().call({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', gas:5000000})
    .then((res) => {
        console.log('Your influence is: ' + res);
    })
    contract.methods.GetMemberRank().call({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', gas:5000000})
    .then((res) => {
        console.log('Your rank is: ' + res);
    })
}

function SendJoinTheCause(){
    contract.methods.JoinTheCause().send({from: '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC', value:2*(10**18), gas:6721974})
    .then((res) => {
        console.log(res);

        contract.methods.GetTotalInfluence().call()
        .then(console.log)
    })
    .catch(console.log)
}