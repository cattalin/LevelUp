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

    function GetPrettyRank(Ranks rank) public pure returns(string memory){
        require(uint8(rank) <= 12 && uint8(rank) >= 0, 'Invalid rank provided');

        if (Ranks.Calfa == rank) return "Calfa";
        if (Ranks.Pacalici == rank) return "Pacalici";
        if (Ranks.Lingau == rank) return "Lingau";
        if (Ranks.LingauAvansat == rank) return "LingauAvansat";
        if (Ranks.Pupincurist == rank) return "Pupincurist";
        if (Ranks.PupincuristInfluent == rank) return "PupincuristInfluent";
        if (Ranks.Influencer == rank) return "Influencer";
        if (Ranks.Manager == rank) return "Manager";
        if (Ranks.BatranIntelept == rank) return "BatranIntelept";
        if (Ranks.Maestru == rank) return "Maestru";
        if (Ranks.MareMaestru == rank) return "MareMaestru";
        if (Ranks.Iluminat == rank) return "Iluminat";
    }
}
