require("@nomicfoundation/hardhat-toolbox");


require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.22",
  networks: {
    monadDevnet: {
      url: process.env.DEVNET_URL, // Load from .env
      chainId: 20143,
      accounts: [process.env.PRIVATE_KEY], // Load private key from .env
    },
  },
};

