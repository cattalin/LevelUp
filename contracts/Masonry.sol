pragma solidity >=0.4.21 <0.7.0;

import "./MasonryLib.sol";

contract Masonry {
    address private owner;
    uint private totalInfluence;
    
    mapping(address => MasonryLib.Member) public members;

    constructor() public{
        owner = msg.sender;
    }

    function JoinTheCause() public payable returns(bool) {
        require(members[msg.sender].isValid == false, "You're already a member. GET BACK TO WORK");
        require(msg.value >= 1 ether, "You think we're playing here?");

        MasonryLib.Member memory newMember = MasonryLib.Member({
            memberAddress: msg.sender,
            currentRank: MasonryLib.Ranks.Calfa,
            gatheredInfluence: 0,
            isValid: true
        });

        uint experienceSurplus = msg.value - 1 ether;
        // i don't think the assignment is needed here. check how memory pass by refernce works here
        newMember = IncreaseMemberExperienceLevel(newMember, experienceSurplus);

        members[msg.sender] = newMember;
        return true;
    }

    function ContributeToTheCause() public payable returns(bool) {
        require(members[msg.sender].isValid == true, "You have to join us first, little man. Yess join us first");

        IncreaseMemberExperienceLevel(members[msg.sender], msg.value);

        return true;
    }

    function IncreaseMemberExperienceLevel(MasonryLib.Member memory goodWillingMember, uint value) internal returns(MasonryLib.Member memory) {
        goodWillingMember.gatheredInfluence += value / 1 szabo;
        totalInfluence += value;

        return goodWillingMember;
    }

    function RecalculateLevel() private {

    }

    function EnvySomeone(address target) public payable {

    }

    function GossipSomeone(address target) public payable {

    }

    function GetTotalInfluence() public view returns(uint){
        return totalInfluence;
    }

    function GetMemberInfluence() public view OneOfUs returns(uint) {
        return members[msg.sender].gatheredInfluence;
    }

    function GetMemberRank() public view OneOfUs returns(string memory) {
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

    modifier OneOfUs() {
        require(members[msg.sender].isValid, "We don't recognize you as one of us");
        _;
    }
}