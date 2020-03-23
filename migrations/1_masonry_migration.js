const Masonry = artifacts.require("Masonry");
const MasonryLib = artifacts.require("MasonryLib");
const MasonryCore = artifacts.require("MasonryCore");

module.exports = function(deployer) {
  deployer.deploy(MasonryLib);
  deployer.link(MasonryLib, MasonryCore);
  deployer.deploy(MasonryCore);
  deployer.link(MasonryLib, Masonry);
  deployer.deploy(Masonry);
};
