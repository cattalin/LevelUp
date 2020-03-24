import { ToEthereum } from './Utils.mjs';
import { contract } from "./Infrastructure";
import { CallMemberStatuses, SendJoinTheCause, SendContributeToTheCause } from "./ContractCalls.mjs"

var value = ToEthereum(2);
console.log(value)
var memberAddress = '0xfc1Ee3C66b6a25Dc0c88bA85D2f37496Cd0250eC';
var ownerAddress = '0xfB1aeBC7606Ed73f95D7713d1Af2BA0f9c834999';

CallMemberStatuses(memberAddress);
SendJoinTheCause(memberAddress, value);
CallMemberStatuses(memberAddress);
SendContributeToTheCause(memberAddress, value);
CallMemberStatuses(memberAddress);
