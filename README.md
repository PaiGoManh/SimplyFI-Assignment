# Assignment: Steps for Installing and Instantiating Chaincode on Hyperledger Fabric 2.2

## 1. Commands for Installing and Running Hyperledger Fabric

### Step 1: Download and Prepare the Installation Script
### Download the install-fabric.sh script from the Hyperledger Fabric GitHub repository and make it executable:

```bash
curl -sSLO https://raw.githubusercontent.com/hyperledger/fabric/main/scripts/install-fabric.sh && chmod +x install-fabric.sh

```

### Step 2: Install Hyperledger Fabric and Fabric-CA
### Install Hyperledger Fabric version 2.2.2 and Fabric-CA version 1.4.9:

```bash
./install-fabric.sh -f '2.2.2' -c '1.4.9'

```

### Step 3: Move to the Test Network Directory
### Navigate to the directory containing the sample test network setup files:

```bash
cd fabric-samples/test-network/
```

### Step 4: Start the Test Network and Create a Channel
### Start the network and set up a communication channel between organizations:

```bash
./network.sh up createChannel
```

### Step 5: Deploy the Chaincode
### Deploy the chaincode basic to the channel, specifying its path and language:

```bash
./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-javascript -ccl javascript
```

### Step 6: Set Environment Variables
### Set up environment variables to provide paths and configurations:

```bash
export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
```

### Step 7: Initialize the Ledger
### Run the InitLedger function to initialize the blockchain ledger:

```bash
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'
```

### Step 8: Retrieve All Assets
### Query the blockchain ledger to retrieve all assets using the GetAllAssets function:

```bash
peer chaincode query -C mychannel -n basic -c '{"Args":["GetAllAssets"]}'
```

### Step 9: Stop the Network
### Shut down the test network and clean up resources:

```bash
./network.sh down
```

## 2. Explain Cryptogen and Configtxgen

### cryptogen

#### The Cryptogen tool is used to generate cryptographic material, such as private keys, certificates, and MSP (Membership Service Provider) 
#### structures for the network’s organizations, peers, and orderers. These materials are essential for ensuring secure communication within 
#### the network.

### Features:
#### Generates the certificates required to identify organizations, peers, and orderers.
#### Structures the cryptographic material in the required directory format for Fabric components

### Configtxgen

#### The Configtxgen tool is used to create configuration transactions for the blockchain network. These transactions define the channel and 
#### system configurations, including policies, consortium details, and channel settings.

### Features:
#### Generates the genesis block for the ordering service.
#### Creates channel configuration transactions and anchor peer updates.


## 3.Develop a chaincode for storing the data in to blockchain

### clone my respository

```bash
https://github.com/PaiGoManh/SimplyFI-Assignment.git
```
### change directory

```bash
cd HarvestHome
```
### run the script file to automate the initialization and setup of the blockchain network.

#### for all scripts you need to do the chmod +x function to read write the script so first do that and then all scriptfiles 

```bash
./startNetwork-Harvest2Home.sh
```
### after the project up 

### a. Store

#### run the below script to add products 

```bash
./a-storeAddProducts.sh
```

### b. Retrieve

#### run the below script to retrieve a product data stored 
#### also make sure change the product id to your product id in the script file go through the script file for changes 

```bash
./b-queryProduct.sh 
```
### c. Update

#### run the below script to approve a product 
#### also make sure change the product id to your product id in the script file go through the script file for changes 

```bash
./c-updateApproveProduct.sh
```

### d. GetHistory

#### run the below script to get a product history
#### also make sure change the product id to your product id in the script file go through the script file for changes 

```bash
./d-getHistory.sh
```

### e. GetbyNonPrimaryKey (Using CouchDB Rich Queries)

#### run the below script to filter product data based on fields like im using - status:approved products only in this script
#### go through the script file for changes 

```bash
./e-GetbyNonPrimaryKey.sh
```

### after all stop the network using the below script

```bash
./stopNetwork-Harvest2Home.sh 
```



