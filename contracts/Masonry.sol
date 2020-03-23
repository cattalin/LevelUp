pragma solidity >=0.4.21 <0.7.0;

import { MasonryLib as Lib } from "./MasonryLib.sol";
import { MasonryCore as Core } from "./MasonryCore.sol";

contract Masonry is Core {
    constructor() public {
        owner = msg.sender;
    }

    function JoinTheCause() external payable MinimumOperationPrice(1 ether) returns(bool) {
        require(members[msg.sender].isValid == false, "You're already a member. GET BACK TO WORK");

        Lib.Member memory newMember = Lib.Member({
            memberAddress: msg.sender,
            currentRank: Lib.Ranks.Calfa,
            gatheredInfluence: 0,
            isValid: true
        });

        uint experienceSurplus = msg.value - 1 ether;
        CashIn(1 ether);

        // i don't think the assignment is needed here. check how memory pass by refernce works here
        newMember = IncreaseMemberExperienceLevel(newMember, experienceSurplus);

        members[msg.sender] = newMember;
        return true;
    }

    function ContributeToTheCause() external payable MinimumOperationPrice(1 szabo) returns(bool) {
        require(members[msg.sender].isValid == true, "You have to join us first, little man. Yess, join us first");

        IncreaseMemberExperienceLevel(members[msg.sender], msg.value);

        return true;
    }

    function IncreaseMemberExperienceLevel(Lib.Member memory goodWillingMember, uint value) internal returns(Lib.Member memory) {
        goodWillingMember.gatheredInfluence += value / 1 szabo;
        CashIn(value);

        return goodWillingMember;
    }

    function LevelUp() external payable YouAreOneOfUs {
        
    }

    function EnvySomeone(address target) public payable MinimumOperationPrice(10 szabo) BothAreOneOfUs(target) TargetIsHigherInRank(target) {
        require(msg.value > 1 szabo, "You can't envy for free");

        members[target].gatheredInfluence -= msg.value / 2 szabo;
        members[msg.sender].gatheredInfluence += msg.value / 2 szabo;
        CashIn(msg.value);
    }

    function GossipSomeone(address target) public payable MinimumOperationPrice(20 szabo) BothAreOneOfUs(target) TargetIsLowerInRank(target) {
        members[target].gatheredInfluence -= msg.value / 2 szabo;
        members[msg.sender].gatheredInfluence += msg.value / 2 szabo;
        CashIn(msg.value);
    }

    function BreakPonziScheme(uint value) external {
        require(msg.sender == owner, "WTF are you doing here?");
        require(value <= totalInfluence, "Sorry boss, you are asking too much");

        CashOut(value);
        msg.sender.transfer(value);
    }

    function CashIn(uint value) private {
        totalInfluence += value;
    }

    function CashOut(uint value) private {
        totalInfluence -= value;
    }

    function GetMemberRank() public view YouAreOneOfUs returns(string memory) {
        return Lib.GetPrettyRank(members[msg.sender].currentRank);
    }

    function GetMemberInfluence() external view YouAreOneOfUs returns(uint) {
        return members[msg.sender].gatheredInfluence;
    }

    function GetTotalInfluence() external view returns(uint){
        return totalInfluence;
    }
}