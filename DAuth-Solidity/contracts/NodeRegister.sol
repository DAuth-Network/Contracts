// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.18;

/** 
 * @title NodeRegister
 */
contract NodeRegister {

    address[] registeredNodes;
    address private owner;
  
     // Defining a constructor   
    constructor() public {   
        owner = msg.sender;
    }

    function register(string memory proof, address nodeAddress) public returns (uint256) {
        if (msg.sender != owner) {
            return 99999;
        }
        if (verifyProof(proof)) {
            registeredNodes.push(nodeAddress);
            return (registeredNodes.length - 1);
        }
        return 99999;
    }

    function getNodeAddress (uint8 nodeNumber) public view returns (address) {
        if(registeredNodes.length <= nodeNumber) {
            return address(0);
        }
        return registeredNodes[nodeNumber];
    }

    function getNodeList () public view returns (address[] memory) {
        return registeredNodes;
    }

    function verifyProof(string memory proof) private view returns (bool)
    {
        // TODO
        return true;
    }
}
