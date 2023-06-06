# Blockchain Oracles (Provable and Chainlink)

Within this repository, you will find three directories: Provable, Chainlink, and DataSource. Each directory serves a specific purpose in the overall functionality of the project.

The Provable directory contains relevant files and resources related to the Provable oracle integration. This integration allows the smart contracts to interact with external data sources and retrieve necessary information for the application's functionality.

Similarly, the Chainlink directory holds the necessary files and resources for integrating with the Chainlink oracle. The Chainlink integration provides a decentralized oracle network that facilitates the retrieval of external data within the smart contracts.

Lastly, the DataSource directory encompasses the files and resources for the Data source web application. This web application acts as a source of data for the smart contracts, providing the necessary information for their operations. To understand how the Data source web application works in detail, please refer to the README file located within this directory.

## Oracles Setup

You need to perform multiple steps.

1. Import the oracles in Remix IDE or copy-paste the code from the files.
2. Create an Ethereum address (e.g., MetaMask is the recommended option).
3. Add the two testnets for the oracles. Sepolia for Chainlink, Goerli for Provable.
4. Go to a faucet for your testnet and request tokens.
5. Go back to Remix IDE and compile the contracts and then go to deployment.
6. Change the deployment to *Injected Provider*.
7. Click "deploy". Wait for a few confirmations, and your contract is now deployed.
8. On the left, you should see your contract variables and functions. If not, click on the contract address that just appeared.
9. Click on the function to send requests (requestLatestPost for Chainlink, updateArticle for Provable).
10. Confirm the transaction.
11. Wait for the request to be processed, it should require a couple of transactions.
12. Now click on the buttons with the names of the variables of the contract, they should be updated.

## Video Demos

The provided demos offer a visual representation of the oracle's functionality by showcasing its interaction with both a data source and a data destination. Through the videos, you will observe the seamless communication between the oracle and the data source, demonstrating how data is retrieved and processed. Additionally, the demos highlight the utilization of the oracle's state by the data destination, showcasing the effective querying of information. While these videos primarily emphasize the integration with the Chainlink oracle, they provide valuable insights into the overall workings and capabilities of the oracle system.

Long version: https://youtu.be/in5Bxblfmdk

Short version: https://youtu.be/iB1xukKEpvk

## Oracles Services

**Provable:** https://provable.xyz

**Chainlink:** https://chain.link
