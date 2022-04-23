const { ethers } = require("hardhat");



async function main() {
  // const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorld");
  const SuperMarioWorld = await ethers.getContractFactory("SuperMarioWorldOZ");

  // deploy version 
  const superMarioWorld = await SuperMarioWorld.deploy("SuperMarioWorldOZ", "SPRMO");

  await superMarioWorld.deployed();
  console.log("Success !, Contract was deployed to :", superMarioWorld.address);

  // await superMarioWorld.mint("https://ipfs.io/ipfs/  QmcPP5Dc7Sxe412uWRgBtigYUqfLw9QXdM7Ckv42g7MN51"); --- for Mario
  await superMarioWorld.mint("https://ipfs.io/ipfs/QmPFzjfJbGJRfdYkEDsUP1zadKiuJBhoNv4dNuLzL5ydjG"); // ---for Luigi

  console.log("NFT successfully minted");

}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
