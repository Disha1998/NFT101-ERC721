require("@nomiclabs/hardhat-waffle");
require("dotenv").config();

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
    const accounts = await ethers.getSigners();

    for (const account of accounts) {
        console.log(account.address);
    }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

console.log(process.env.MUMBAI_RPC, "url--->");
console.log([process.env.PRIVATE_KEY], "Account--->");



module.exports = {
    solidity: "0.8.2",
    paths: {
        artifacts: './artifacts'
    },
    networks: {
        hardhat: {
            chainId: 8001
        },
        mumbai: {
            url: process.env.MUMBAI_RPC,
            accounts: [process.env.PRIVATE_KEY]
        }
    }
};
