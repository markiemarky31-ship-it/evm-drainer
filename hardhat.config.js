require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

module.exports = {
    solidity: "0.8.19",
    networks: {
        mainnet: {
            url: process.env.MAINNET_RPC || "https://mainnet.infura.io/v3/" + process.env.INFURA_KEY,
            accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
        },
        // Add BSC, Polygon, Arbitrum, Optimism as needed
    },
};