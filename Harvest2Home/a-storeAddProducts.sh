export CHANNEL_NAME=harvest-channel
export FABRIC_CFG_PATH=./peercfg
export CORE_PEER_LOCALMSPID=FarmerMSP
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/users/Admin@farmer.harvest2home.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt
export FARMER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export DELIVERYPARTNER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CONSUMERASSOCIATION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export QUALITYASSURANCE_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"addProduct","Args":["Apple", "fruit", "25", "100","farmer1"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"addProduct","Args":["Banana", "fruit", "20", "150", "farmer2"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"addProduct","Args":["Carrot", "vegetable", "15", "200", "farmer3"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"addProduct","Args":["Tomato", "vegetable", "30", "250", "farmer4"]}'

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.harvest2home.com  --tls --cafile $ORDERER_CA -C $CHANNEL_NAME -n Harvest2home --peerAddresses localhost:7051 --tlsRootCertFiles $FARMER_PEER_TLSROOTCERT --peerAddresses localhost:9051 --tlsRootCertFiles $DELIVERYPARTNER_PEER_TLSROOTCERT --peerAddresses localhost:10051 --tlsRootCertFiles $CONSUMERASSOCIATION_PEER_TLSROOTCERT --peerAddresses localhost:12051 --tlsRootCertFiles $QUALITYASSURANCE_PEER_TLSROOTCERT -c '{"function":"addProduct","Args":["Potato", "vegetable", "10", "300", "farmer5"]}'
