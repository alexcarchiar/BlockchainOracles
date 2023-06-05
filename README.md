# BlockchainOracles

 Repo with all of the code written for my research on blockchain oracles.

Open the two directories `ChainlinkOracle` and `ProvableOracle` to find the consumer smart contracts used to interact with the oracles and the data source. The `DataSource` directory contains the Data source web application. Read its README to know how the app works. I recommend reading the paper for more information (I will add the links here once available)

**Video demos**
These demos show how the oracle work with a Data source and a data destination that queries the state of the oracles. The videos only interact with the Chainlink oracle.
Long version: https://youtu.be/in5Bxblfmdk
Short version: https://youtu.be/iB1xukKEpvk

**Run oracles**
If you want to run the oracles, you need to perform multiple steps.
1. import the oracles in Remix IDE. You can just copy-paste the files.
2. Create an ethereum address. MetaMask is the recommended option.
3. Add the two testnets for the oracles. Sepolia for Chainlink, Goerli for Provable (but Sepolia should work too, but it is untested).
4. Go to a faucet for your testnet and request tokens. There are multiple different faucets with different ways to request tokens.
5. Go back to Remix. Now compile the contracts and then go to deployment.
6. Change the deployment to *Injected Provider*.
7. Click "deploy". Wait for a few confirmations, but your contract is now deployed
8. On the left, you should see your contract variables and functions. If not, click on the contract address that just appeared.
9. Click on the function to send requests (requestLatestPost for Chainlink, updateArticle for Provable)
10. Confirm the transaction
11. Wait for the request to be processed, it should require a couple of transactions
12. Now click on the buttons with the names of the variables of the contract: they should be updated.

Congratulations! You managed to run the oracles!
