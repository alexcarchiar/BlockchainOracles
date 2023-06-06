// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**  
 * This import is to inherit the Chainlink interface to communicate with oracle nodes.
 * The methods setChainlinkToken and setChainlinkOracle are inherited from "ChainlinkClient" contract.
*/
import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol"; 

// This import is to inherit the ConfirmedOwner modifier which allows to check the owner of the contract.
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

/** 
 * This smart contract specify to get the latest post.
*/
contract GetLatestPost is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    string public title;
    string public description;
    string public signature;
    uint256 public counter;

    // this is the id used by the chainlink node to uniquely identify the job we want to use
    bytes32 private jobId;
    
    // this is the fee that we are willling to pay for a request. We pay every time we perform a successful request.
    uint256 private fee;

    event RequestLatestPost(bytes32 indexed requestId, string title);

    /**
     * @notice Initialize the link token and target oracle
     *
     * Sepolia Testnet details:
     * Link Token: 0x779877A7B0D9E8603169DdbD7836e478b4624789
     * Oracle: 0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD (Chainlink DevRel)
     * jobId: 7d80a6386ef543a3abb52817f6707e3b
     *
     */
    constructor() ConfirmedOwner(msg.sender) {
        /**  
         * Sets the smart contract that specifies the token we want 
         * to use to pay for requests to the Chainlink oracle node. 
         * In this case the address is hardcoded to the address 
         * of the smart contract for LINK tokens on the sepolia testnet
        */
        setChainlinkToken(0x779877A7B0D9E8603169DdbD7836e478b4624789);
       
        /** 
         * Specifies the oracle node that we want to interact with. 
         * In a production environment, this method would be called 
         * multiple times, whenever it is needed to change the oracle node. 
         * In the testnet, we only have access to one oracle node. 
         * Thus we hardcode the node to that specific oracle node.
        */
        setChainlinkOracle(0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD);
        
        jobId = "7d80a6386ef543a3abb52817f6707e3b";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
        counter = 0;
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target
     * data which is located in a list.
     */
    function requestLatestPost() public returns (bytes32 requestId) {
        Chainlink.Request memory req = buildChainlinkRequest(
            jobId,
            address(this),
            this.fulfill.selector
        );

        req.add(
                "get",
                "https://two-oracle-thesis-web-app.onrender.com/posts/latest"
        );

        if (counter == 0) {
            /*req.add(
                "get",
                "https://two-oracle-thesis-web-app.onrender.com/posts/latest"
            );*/

            req.add("path", "title"); 
        } else if (counter == 1) {
            /*req.add(
                "get",
                "https://two-oracle-thesis-web-app.onrender.com/posts/latest"
            );*/
            req.add("path", "description");
        } else if (counter == 2) {
            /*req.add(
                "get",
                "https://two-oracle-thesis-web-app.onrender.com/posts/latest"
            );*/
            req.add("path", "signature");
        }

        return sendChainlinkRequest(req, fee);
        /* sends a request to the oracle node 
        specified at line 31 and keeps track 
        of a request Id.
        */
    }

    /**
     * Receive the response in the form of string
     */
    function fulfill(
        bytes32 _requestId,
        string memory _currString
    ) public recordChainlinkFulfillment(_requestId) { 
    /* the modifier recordChainlinkFulfillment(_requestId) 
        checks that the request Id that was received is 
        valid and it is the same as the one stored in line 74.
        */
        emit RequestLatestPost(_requestId, _currString);
        if (counter == 0) {
            title = _currString;
            counter = 1;
            requestLatestPost();
        } else if (counter == 1) {
            description = _currString;
            counter = 2;
            requestLatestPost();
        } else if (counter == 2) {
            signature = _currString;
            counter = 0;
        }
    }

    /**
     * Allow withdraw of Link tokens from the contract
     */
    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(
            link.transfer(msg.sender, link.balanceOf(address(this))),
            "Unable to transfer"
        );
    }
}
