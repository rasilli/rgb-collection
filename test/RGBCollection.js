const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("RGBCollection", function () {
  it("Should deploy and mint an NFT", async function () {
    // Get the deployer account
    const [owner] = await ethers.getSigners();

    // Get the contract factory and deploy
    const RGBCollection = await ethers.getContractFactory("RGBCollection");
    const contract = await RGBCollection.deploy(owner.address);

    // Mint an NFT
    const tx = await contract.mint(255, 0, 0); // Mint a red NFT
    await tx.wait(); // Wait for the transaction to complete

    // Verify the color
    const color = await contract.getColor(0);
    expect(color.r).to.equal(255);
    expect(color.g).to.equal(0);
    expect(color.b).to.equal(0);
  });
});
