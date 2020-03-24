pragma solidity >=0.4.21 <0.7.0;
import { MasonryLib as Core } from "./MasonryLib.sol";

contract MasonryCore {
    address internal owner;
    uint internal totalInfluence;
    mapping(address => Core.Member) public members;

    constructor() public {
        owner = msg.sender;
    }

    event MemberJoined();
    event MemberContributed();

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
}