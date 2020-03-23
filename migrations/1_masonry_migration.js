const Masonry = artifacts.require("Masonry");
const MasonryLib = artifacts.require("MasonryLib");
const MasonryCore = artifacts.require("MasonryCore");

//for running tests without redeply
module.exports = function(deployer) {
  deployer.deploy(MasonryLib, {overwrite: false});
  deployer.link(MasonryLib, MasonryCore);
  deployer.deploy(MasonryCore, {overwrite: false});
  deployer.link(MasonryLib, Masonry);
  deployer.deploy(Masonry, {overwrite: false});
}


//for running migrations and clean tests
module.exports = function(deployer) {
  // deployer.deploy(MasonryLib);
  // deployer.link(MasonryLib, MasonryCore);
  // deployer.deploy(MasonryCore);
  // deployer.link(MasonryLib, Masonry);
  // deployer.deploy(Masonry);
};
