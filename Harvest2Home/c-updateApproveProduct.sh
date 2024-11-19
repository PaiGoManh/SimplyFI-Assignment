export CHANNEL_NAME=harvest-channel
export FABRIC_CFG_PATH=./peercfg
export CORE_PEER_LOCALMSPID=QualityAssuranceAgencyMSP
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ADDRESS=localhost:12051
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/users/Admin@quality-assurance-agency.harvest2home.com/msp
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt
export FARMER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export DELIVERYPARTNER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CONSUMERASSOCIATION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export QUALITYASSURANCE_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt

# i set the product id as the transaction id of that product invoke function so copy that product id from invoked list 
# const productId = ctx.stub.getTxID(); // in chaincode 
# enter your productid from invoke succesfull of addproducts

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"approveProduct","Args":["productId"]}'
# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"rejectProduct","Args":["productId", "Quality standards not met"]}'

