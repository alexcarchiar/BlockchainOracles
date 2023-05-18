// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract GetLatestPost is ChainlinkClient, ConfirmedOwner {
    using Chainlink for Chainlink.Request;

    string public title;
    string public description;
    string public signature;
    uint256 public counter;

    bytes32 private jobId;
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
        setChainlinkToken(0x779877A7B0D9E8603169DdbD7836e478b4624789);
        setChainlinkOracle(0x6090149792dAAeE9D1D568c9f9a6F6B46AA29eFD);
        jobId = "7d80a6386ef543a3abb52817f6707e3b";
        fee = (1 * LINK_DIVISIBILITY) / 10; // 0,1 * 10**18 (Varies by network and job)
        counter = 0;
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target
     * data which is located in a list
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
    }

    /**
     * Receive the response in the form of string
     */
    function fulfill(
        bytes32 _requestId,
        string memory _currString
    ) public recordChainlinkFulfillment(_requestId) {
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