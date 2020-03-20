pragma solidity >=0.4.21 <0.7.0;

library MasonryLib {
    enum Ranks {
        Calfa,
        Pacalici,
        Lingau,
        LingauAvansat,
        Pupincurist,
        PupincuristInfluent,
        Influencer,
        Manager,
        BatranIntelept,
        Maestru,
        MareMaestru,
        Iluminat
    }

    struct Member {
        uint gatheredInfluence;
        address memberAddress;
        Ranks currentRank;
        bool isValid;
    }
}
