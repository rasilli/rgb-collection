const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();

  console.log("Deploying the contract with account:", deployer.address);

  const RGBCollection = await hre.ethers.getContractFactory("RGBCollection");
  const contract = await RGBCollection.deploy(deployer.address);

  await contract.deployed();

  console.log("RGBCollection deployed to:", contract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
