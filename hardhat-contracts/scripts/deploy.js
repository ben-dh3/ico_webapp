const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {
  const cryptoTokenContract = await ethers.getContractFactory("CryptoToken");
  const deployedCryptoTokenContract = await cryptoTokenContract.deploy();
  console.log("Crypto Token Contract Address:",deployedCryptoTokenContract.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });