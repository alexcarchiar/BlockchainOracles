pragma solidity ^0.4.22;

import "https://github.com/provable-things/ethereum-api/blob/master/contracts/solc-v0.4.25/provableAPI.sol"; //This import is to inherit the interface to communicate with Provable oracle service

contract ExampleContract is usingProvable {

    string public latestArticle;
    bytes public AuthenticityProof;
    mapping(bytes32=>bool) validIds;
   
    event LogConstructorInitiated(string nextStep);
    event LogArticleUpdated(string article);
    event LogNewProvableQuery(string description);

    function ExampleContract() payable {
        provable_setProof(proofType_TLSNotary | proofStorage_IPFS);
        LogConstructorInitiated("Constructor was initiated. Call 'updateArticle() to send the Provable Query.");
    }

    function __callback(bytes32 myid, string result, bytes proof) {
        if (!validIds[myid]) revert();
        if (msg.sender != provable_cbAddress()) revert();
        latestArticle = result;
        AuthenticityProof = proof;
        LogArticleUpdated(result);
    }

    function updateArticle() payable {
        if (provable_getPrice("URL") > this.balance){
            LogNewProvableQuery("Provable query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            LogNewProvableQuery("Provable query was sent, standing by for the answer..");
            bytes32 queryId = provable_query("URL", "json(https://two-oracle-thesis-web-app.onrender.com/posts/latest).0");
            validIds[queryId] = true;
        }
    }
}
