// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.18;
import './NodeRegister.sol';

contract DAuthVerify {

    NodeRegister private nodeRegisterInstance;

    //Set the address of the deployed OtherContract in the constructor
    
    constructor(address _nodeRegisterAddress) {
        nodeRegisterInstance = NodeRegister(_nodeRegisterAddress);
    }

    event StringsVerified(string accountHash, string requestId);

    function verify(
        uint8 _v, 
        bytes32 _r, 
        bytes32 _s,
        string memory accountHash,
        string memory requestId,
        uint8 nodeNumber
    ) public returns (bool) {

        address nodeAddress = nodeRegisterInstance.getNodeAddress(nodeNumber);
        bytes32 hashMessage = keccak256(abi.encodePacked(accountHash, requestId));

        if( verifySignature(hashMessage, _v, _r, _s, nodeAddress) == true) {
            emit StringsVerified(accountHash, requestId);
            return true;
        }
        return false;
    }

    function verifySignature(bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s, address _node) private view returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix, _hashedMessage));
        address signer = ecrecover(prefixedHashMessage, _v, _r, _s);
        // if the signature is signed by the node
        if (signer == _node) {
            return true;
        }
        return false;
    }

}