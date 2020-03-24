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

export { web3, contract, contractAddress }