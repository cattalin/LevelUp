import { ToEthereum } from "./Utils";
import { contract } from "./Infrastructure";

export {
    CallMemberStatuses,
    SendJoinTheCause,
    SendContributeToTheCause,
    CallGetTotalInfluence,
    SendStealMoney,
}

var defaultGasValue = 5000000;

function CallMemberStatuses(address) {
    contract.methods.GetMemberInfluence().call({ from: address, gas: defaultGasValue })
        .then((res) => {
            console.log('Your influence is: ' + res);
        })
        .catch(console.log)
    contract.methods.GetMemberRank().call({ from: address, gas: defaultGasValue })
        .then((res) => {
            console.log('Your rank is: ' + res);
        })
        .catch(console.log)
}

function SendJoinTheCause(address, value) {
    contract.methods.JoinTheCause().send({ from: address, value: value, gas: defaultGasValue })
        .then((res) => {
            console.log(res);

            contract.methods.GetTotalInfluence().call()
                .then(console.log)
        })
        .catch(console.log)
}

function SendContributeToTheCause(address, value) {
    contract.methods.JoinTheCause().send({ from: address, value: value, gas: defaultGasValue })
        .then((res) => {
            console.log(res);

            contract.methods.GetTotalInfluence().call()
                .then(console.log)
        })
        .catch(console.log)
}

function CallGetTotalInfluence(ownerAddress) {
    contract.methods.GetTotalInfluence().call({ from: ownerAddress, gas: defaultGasValue })
        .then((res) => {
            console.log('Your influence is: ' + res);
        })
        .catch(console.log)
}

function SendStealMoney(ownerAddress) {
    let desiredValue = ToEthereum(0.5);

    contract.methods.BreakPonziScheme(toHex(desiredValue)).send({ from: ownerAddress, gas: defaultGasValue })
        .then((res) => {
            console.log(res);

            contract.methods.GetTotalInfluence().call()
                .then(console.log)
        })
        .catch(console.log)
}