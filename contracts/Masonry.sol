pragma solidity >=0.4.21 <0.7.0;

import "./MasonryLib.sol";

contract Masonry {
    address private owner;
    uint private totalInfluence;
    
    mapping(address => MasonryLib.Member) public members;

    constructor() public{
        owner = msg.sender;
    }

    function JoinTheCause() public payable MinimumOperationPrice(1 ether) returns(bool) {
        require(members[msg.sender].isValid == false, "You're already a member. GET BACK TO WORK");

        MasonryLib.Member memory newMember = MasonryLib.Member({
            memberAddress: msg.sender,
            currentRank: MasonryLib.Ranks.Calfa,
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

    function ContributeToTheCause() public payable MinimumOperationPrice(1 szabo) returns(bool) {
        require(members[msg.sender].isValid == true, "You have to join us first, little man. Yess, join us first");

        IncreaseMemberExperienceLevel(members[msg.sender], msg.value);

        return true;
    }

    function IncreaseMemberExperienceLevel(MasonryLib.Member memory goodWillingMember, uint value) internal returns(MasonryLib.Member memory) {
        goodWillingMember.gatheredInfluence += value / 1 szabo;
        CashIn(value);

        return goodWillingMember;
    }

    function CashIn(uint value) private {
        totalInfluence += value;
    }

    function LevelUp() public payable YouAreOneOfUs {
        
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

    function GetTotalInfluence() public view returns(uint){
        return totalInfluence;
    }

    function GetMemberInfluence() public view YouAreOneOfUs returns(uint) {
        return members[msg.sender].gatheredInfluence;
    }

    function GetMemberRank() public view YouAreOneOfUs returns(string memory) {
        return GetPrettyRank(members[msg.sender].currentRank);
    }

    function GetPrettyRank(MasonryLib.Ranks rank) private pure returns(string memory){
        require(uint8(rank) <= 12, 'Wrong rank');
        if (MasonryLib.Ranks.Calfa == rank) return "Calfa";
        if (MasonryLib.Ranks.Pacalici == rank) return "Pacalici";
        if (MasonryLib.Ranks.Lingau == rank) return "Lingau";
        if (MasonryLib.Ranks.LingauAvansat == rank) return "LingauAvansat";
        if (MasonryLib.Ranks.Pupincurist == rank) return "Pupincurist";
        if (MasonryLib.Ranks.PupincuristInfluent == rank) return "PupincuristInfluent";
        if (MasonryLib.Ranks.Influencer == rank) return "Influencer";
        if (MasonryLib.Ranks.Manager == rank) return "Manager";
        if (MasonryLib.Ranks.BatranIntelept == rank) return "BatranIntelept";
        if (MasonryLib.Ranks.Maestru == rank) return "Maestru";
        if (MasonryLib.Ranks.MareMaestru == rank) return "MareMaestru";
        if (MasonryLib.Ranks.Iluminat == rank) return "Iluminat";
    }

    modifier YouAreOneOfUs() {
        require(members[msg.sender].isValid, "We don't recognize you as one of us");
        _;
    }

    modifier TargetIsOneOfUs(address target) {
        require(members[target].isValid, "We don't recognize him as one of us");
        _;
    }

    modifier BothAreOneOfUs(address target) {
        require(members[msg.sender].isValid, "We don't recognize you as one of us");
        require(members[target].isValid, "We don't recognize him as one of us");
        _;
    }

    modifier TargetIsHigherInRank(address target) {
        require(members[msg.sender].currentRank <= members[target].currentRank, "You are higher in rank than him");
        _;
    }

    modifier TargetIsLowerInRank(address target) {
        require(members[msg.sender].currentRank >= members[target].currentRank, "He is higher in rank than you");
        _;
    }

    modifier MinimumOperationPrice(uint value) {
        require(msg.value >= value, "You can't do this for free");
        _;
    }

    function BreakPonziScheme(uint value) external {
        require(msg.sender == owner, "WTF are you doing here?");
        require(value <= totalInfluence, "Sorry boss, you are asking too much");

        totalInfluence -= value;
        msg.sender.transfer(value);
    }
}