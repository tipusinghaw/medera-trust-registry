// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustRegistry {
    // Mapping of Hedera DID to associated resources (array of strings)
    mapping(string => string[]) private didToResources;

    // Array to track all DIDs
    string[] private dids;

    // Event emitted when a resource is added
    event ResourceAdded(string indexed did, string resource);

    // Event emitted when a resource is removed
    event ResourceRemoved(string indexed did, string resource);

    // Event emitted when all resources of a DID are cleared
    event ResourcesCleared(string indexed did);

    /**
     * @dev Adds a resource to the specified DID.
     * @param did The Hedera DID.
     * @param resource The resource to associate with the DID (e.g., schema, URL).
     */
    function addResource(string memory did, string memory resource) public {
        // Add the DID to the list if it's new
        if (didToResources[did].length == 0) {
            dids.push(did);
        }
        didToResources[did].push(resource);
        emit ResourceAdded(did, resource);
    }

    /**
     * @dev Removes a specific resource from the specified DID.
     * @param did The Hedera DID.
     * @param resource The resource to remove.
     */
    function removeResource(string memory did, string memory resource) public {
        string[] storage resources = didToResources[did];
        for (uint256 i = 0; i < resources.length; i++) {
            if (keccak256(abi.encodePacked(resources[i])) == keccak256(abi.encodePacked(resource))) {
                resources[i] = resources[resources.length - 1];
                resources.pop();
                emit ResourceRemoved(did, resource);
                return;
            }
        }
        revert("Resource not found");
    }

    /**
     * @dev Gets all resources associated with the specified DID.
     * @param did The Hedera DID.
     * @return An array of associated resources.
     */
    function getResources(string memory did) public view returns (string[] memory) {
        return didToResources[did];
    }

    /**
     * @dev Clears all resources associated with the specified DID.
     * @param did The Hedera DID.
     */
    function clearResources(string memory did) public {
        delete didToResources[did];
        emit ResourcesCleared(did);
    }

    /**
     * @dev Checks if a specific resource exists for a given DID.
     * @param did The Hedera DID.
     * @param resource The resource to check.
     * @return A boolean indicating whether the resource exists.
     */
    function resourceExists(string memory did, string memory resource) public view returns (bool) {
        string[] memory resources = didToResources[did];
        for (uint256 i = 0; i < resources.length; i++) {
            if (keccak256(abi.encodePacked(resources[i])) == keccak256(abi.encodePacked(resource))) {
                return true;
            }
        }
        return false;
    }

    /**
     * @dev Checks if a DID exists in the smart contract.
     * @param did The Hedera DID.
     * @return A boolean indicating whether the DID exists.
     */
    function isResourceExist(string memory did) public view returns (bool) {
        return didToResources[did].length > 0;
    }

    /**
     * @dev Gets all DIDs and their associated resources.
     * @return An array of all DIDs and their associated resources.
     */
    function getAllResources() public view returns (string[] memory, string[][] memory) {
        string[][] memory allResources = new string[][](dids.length);
        for (uint256 i = 0; i < dids.length; i++) {
            allResources[i] = didToResources[dids[i]];
        }
        return (dids, allResources);
    }
}