# Farmer
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

# QualityAgency
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

# ConsumerAssosiation
export CHANNEL_NAME=harvest-channel
export FABRIC_CFG_PATH=./peercfg 
export CORE_PEER_LOCALMSPID=ConsumersAssociationMSP
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ADDRESS=localhost:10051
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/Admin@consumer-association.harvest2home.com/msp
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt
export FARMER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export DELIVERYPARTNER_PEER_TLSROexport CHANNEL_NAME=harvest-channel
export FABRIC_CFG_PATH=./peercfg 
export CORE_PEER_LOCALMSPID=ConsumersAssociationMSP
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_ADDRESS=localhost:10051
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/Admin@consumer-association.harvest2home.com/msp
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt
export FARMER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export DELIVERYPARTNER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CONSUMERASSOCIATION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export QUALITYASSURANCE_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt
OTCERT=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CONSUMERASSOCIATION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export QUALITYASSURANCE_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt

# DeliveryPartner
export CHANNEL_NAME=harvest-channel
export FABRIC_CFG_PATH=./peercfg 
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID=DeliverypartnerMSP
export CORE_PEER_ADDRESS=localhost:9051
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/users/Admin@delivery-partner.harvest2home.com/msp
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt
export FARMER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt
export DELIVERYPARTNER_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt
export CONSUMERASSOCIATION_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt
export QUALITYASSURANCE_PEER_TLSROOTCERT=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt

