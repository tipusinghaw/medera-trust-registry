# TrustRegistry Smart Contract
![Medera Logo](./assets/medera.png) 
## Overview
The `TrustRegistry` is a smart contract that provides functionality for managing a registry of Hedera DIDs (Decentralized Identifiers) and their associated resources. Resources can include schemas, URLs, or other relevant metadata. The contract enables adding, removing, and retrieving resources linked to specific DIDs while maintaining an organized list of all DIDs.

## Features
- **Add Resources**: Associate resources with a specific DID.
- **Remove Resources**: Remove a specific resource associated with a DID.
- **Clear Resources**: Clear all resources linked to a DID.
- **Check Existence**: Verify if a resource or DID exists.
- **Retrieve Resources**: Retrieve resources linked to a specific DID or fetch all DIDs and their resources.
- **Event Emissions**: Emit events for key actions (e.g., adding or removing resources).

## Contract Details
### State Variables
- `mapping(string => string[]) private didToResources`: Maps a Hedera DID to its associated resources (array of strings).
- `string[] private dids`: Array to store all DIDs that have associated resources.

### Events
- `event ResourceAdded(string indexed did, string resource)`: Emitted when a resource is added to a DID.
- `event ResourceRemoved(string indexed did, string resource)`: Emitted when a resource is removed from a DID.
- `event ResourcesCleared(string indexed did)`: Emitted when all resources associated with a DID are cleared.

### Functions
#### 1. `addResource(string memory did, string memory resource)`
Adds a resource to a specified DID.
- **Parameters**:
  - `did`: The Hedera DID.
  - `resource`: The resource to associate with the DID.
- **Functionality**:
  - Adds the DID to the `dids` array if it is new.
  - Adds the resource to the DID's list of resources.
  - Emits the `ResourceAdded` event.

#### 2. `removeResource(string memory did, string memory resource)`
Removes a specific resource from a DID.
- **Parameters**:
  - `did`: The Hedera DID.
  - `resource`: The resource to remove.
- **Functionality**:
  - Searches for the resource in the DID's resource list.
  - Removes the resource and reorders the list.
  - Emits the `ResourceRemoved` event.
  - Reverts with "Resource not found" if the resource does not exist.

#### 3. `getResources(string memory did)`
Retrieves all resources associated with a DID.
- **Parameters**:
  - `did`: The Hedera DID.
- **Returns**:
  - An array of resources associated with the DID.

#### 4. `clearResources(string memory did)`
Clears all resources associated with a DID.
- **Parameters**:
  - `did`: The Hedera DID.
- **Functionality**:
  - Deletes all resources associated with the DID in the mapping.
  - Emits the `ResourcesCleared` event.

#### 5. `resourceExists(string memory did, string memory resource)`
Checks if a specific resource exists for a DID.
- **Parameters**:
  - `did`: The Hedera DID.
  - `resource`: The resource to check.
- **Returns**:
  - `true` if the resource exists, `false` otherwise.

#### 6. `isResourceExist(string memory did)`
Checks if a DID exists in the contract.
- **Parameters**:
  - `did`: The Hedera DID.
- **Returns**:
  - `true` if the DID has associated resources, `false` otherwise.

#### 7. `getAllResources()`
Retrieves all DIDs and their associated resources.
- **Returns**:
  - An array of all DIDs.
  - A two-dimensional array of resources associated with each DID.

## Example Usage
### Add a Resource
```solidity
trustRegistry.addResource("did:hedera:12345", "https://example.com/schema");
```
### Remove a Resource
```solidity
trustRegistry.removeResource("did:hedera:12345", "https://example.com/schema");
```
### Retrieve Resources for a DID
```solidity
string[] memory resources = trustRegistry.getResources("did:hedera:12345");
```
### Check if a Resource Exists
```solidity
bool exists = trustRegistry.resourceExists("did:hedera:12345", "https://example.com/schema");
```
### Clear Resources for a DID
```solidity
trustRegistry.clearResources("did:hedera:12345");
```
### Get All DIDs and Their Resources
```solidity
(string[] memory allDIDs, string[][] memory allResources) = trustRegistry.getAllResources();
```

## Security Considerations
- Ensure that only authorized users interact with the contract.
- Validate input data to prevent malicious data injection.
### Thank you,

![Hedera Logo](./assets/hedera.png)