#!/bin/bash

function createFarmer() {
  echo "Enrolling the CA admin for Farmer"
  mkdir -p organizations/peerOrganizations/farmer.harvest2home.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-farmer --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-farmer.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/config.yaml"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/tlsca"
  cp "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/tlsca/tlsca.farmer.harvest2home.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/ca"
  cp "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/ca/ca.farmer.harvest2home.com-cert.pem"

  echo "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering peer1"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering user1"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering org admin"
  set -x
  fabric-ca-client register --caname ca-farmer --id.name farmeradmin --id.secret farmeradminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Peer0 MSP and TLS certificates
  echo "Generating the peer0 MSP"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/msp/config.yaml"

  echo "Generating the peer0 TLS certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls" --enrollment.profile tls --csr.hosts peer0.farmer.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer0.farmer.harvest2home.com/tls/server.key"

  # Peer1 MSP and TLS certificates
  echo "Generating the peer1 MSP"
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/msp/config.yaml"

  echo "Generating the peer1 TLS certificates"
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls" --enrollment.profile tls --csr.hosts peer1.farmer.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/peers/peer1.farmer.harvest2home.com/tls/server.key"

  echo "Generating the user MSP"
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/users/User1@farmer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/users/User1@farmer.harvest2home.com/msp/config.yaml"

  echo "Generating the org admin MSP"
  fabric-ca-client enroll -u https://farmeradmin:farmeradminpw@localhost:7054 --caname ca-farmer -M "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/users/Admin@farmer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/farmer/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/farmer.harvest2home.com/users/Admin@farmer.harvest2home.com/msp/config.yaml"
}


function createDeliveryPartner() {
  echo "Enrolling the CA admin for delivery-partner"
  mkdir -p organizations/peerOrganizations/delivery-partner.harvest2home.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca-delivery-partner --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-delivery-partner.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-delivery-partner.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-delivery-partner.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-delivery-partner.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/config.yaml"

  mkdir -p "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/tlsca"
  cp "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/tlsca/tlsca.delivery-partner.harvest2home.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/ca"
  cp "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/ca/ca.delivery-partner.harvest2home.com-cert.pem"

  echo "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-delivery-partner --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering user1"
  set -x
  fabric-ca-client register --caname ca-delivery-partner --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering org admin"
  set -x
  fabric-ca-client register --caname ca-delivery-partner --id.name delivery-partneradmin --id.secret delivery-partneradminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer0 MSP"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-delivery-partner -M "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/msp/config.yaml"

  echo "Generating the peer0 TLS certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca-delivery-partner -M "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls" --enrollment.profile tls --csr.hosts peer0.delivery-partner.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/peers/peer0.delivery-partner.harvest2home.com/tls/server.key"

  echo "Generating the user MSP"
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca-delivery-partner -M "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/users/User1@delivery-partner.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/users/User1@delivery-partner.harvest2home.com/msp/config.yaml"

  echo "Generating the org admin MSP"
  fabric-ca-client enroll -u https://delivery-partneradmin:delivery-partneradminpw@localhost:8054 --caname ca-delivery-partner -M "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/users/Admin@delivery-partner.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/delivery-partner/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/delivery-partner.harvest2home.com/users/Admin@delivery-partner.harvest2home.com/msp/config.yaml"
}

function createConsumerAssosiation() {
  echo "Enrolling the CA admin for consumer-association"
  mkdir -p organizations/peerOrganizations/consumer-association.harvest2home.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca-consumer-association --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"
  { set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-consumer-association.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-consumer-association.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-consumer-association.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-consumer-association.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/config.yaml"

  mkdir -p "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/tlsca"
  cp "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/tlsca/tlsca.consumer-association.harvest2home.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/ca"
  cp "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/ca/ca.consumer-association.harvest2home.com-cert.pem"

  echo "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-consumer-association --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering user1"
  set -x
  fabric-ca-client register --caname ca-consumer-association --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering org admin"
  set -x
  fabric-ca-client register --caname ca-consumer-association --id.name consumer-associationadmin --id.secret consumer-associationadminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer0 MSP" 
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-consumer-association -M "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/msp/config.yaml"

  echo "Generating the peer0 TLS certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca-consumer-association -M "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls" --enrollment.profile tls --csr.hosts peer0.consumer-association.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/peers/peer0.consumer-association.harvest2home.com/tls/server.key"

  echo "Generating the user MSP"
  fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca-consumer-association -M "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/User1@consumer-association.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/User1@consumer-association.harvest2home.com/msp/config.yaml"

  echo "Generating the org admin MSP"
  fabric-ca-client enroll -u https://consumer-associationadmin:consumer-associationadminpw@localhost:11054 --caname ca-consumer-association -M "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/Admin@consumer-association.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/consumer-association/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/consumer-association.harvest2home.com/users/Admin@consumer-association.harvest2home.com/msp/config.yaml"


}

function createQualityAssuranceAgency() {
  echo "Enrolling the CA admin for quality-assurance-agency"
  mkdir -p organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:12054 --caname ca-quality-assurance-agency --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-quality-assurance-agency.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-quality-assurance-agency.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-quality-assurance-agency.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-quality-assurance-agency.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/config.yaml"

  mkdir -p "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/tlsca"
  cp "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/tlsca/tlsca.quality-assurance-agency.harvest2home.com-cert.pem"

  mkdir -p "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/ca"
  cp "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/ca/ca.quality-assurance-agency.harvest2home.com-cert.pem"

  echo "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-quality-assurance-agency --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering user1"
  set -x
  fabric-ca-client register --caname ca-quality-assurance-agency --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering org admin"
  set -x
  fabric-ca-client register --caname ca-quality-assurance-agency --id.name quality-assurance-agencyadmin --id.secret quality-assurance-agencyadminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer0 MSP" 
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca-quality-assurance-agency -M "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/msp/config.yaml"

  echo "Generating the peer0 TLS certificates"
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca-quality-assurance-agency -M "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls" --enrollment.profile tls --csr.hosts peer0.quality-assurance-agency.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/peers/peer0.quality-assurance-agency.harvest2home.com/tls/server.key"

  echo "Generating the user MSP"
  fabric-ca-client enroll -u https://user1:user1pw@localhost:12054 --caname ca-quality-assurance-agency -M "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/users/User1@quality-assurance-agency.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/users/User1@quality-assurance-agency.harvest2home.com/msp/config.yaml"

  echo "Generating the org admin MSP"
  fabric-ca-client enroll -u https://quality-assurance-agencyadmin:quality-assurance-agencyadminpw@localhost:12054 --caname ca-quality-assurance-agency -M "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/users/Admin@quality-assurance-agency.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/quality-assurance-agency/ca-cert.pem"

  cp "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/quality-assurance-agency.harvest2home.com/users/Admin@quality-assurance-agency.harvest2home.com/msp/config.yaml"
}

function createOrderer() {
  echo "Enrolling the CA admin for Orderer"
  
  # Create directories for orderer organizations
  mkdir -p organizations/ordererOrganizations/harvest2home.com

  # Set the CA client home for the orderer organization
  export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/ordererOrganizations/harvest2home.com/

  # Enroll CA admin for the orderer organization
  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Create the config.yaml file for the MSP
  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' > "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/config.yaml"

  # Copy the CA cert to MSP, TLSCA, and CA directories
  mkdir -p "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem" "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/tlscacerts/ca.crt"

  mkdir -p "${PWD}/organizations/ordererOrganizations/harvest2home.com/tlsca"
  cp "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem" "${PWD}/organizations/ordererOrganizations/harvest2home.com/tlsca/tlsca.orderer.harvest2home.com-cert.pem"

  mkdir -p "${PWD}/organizations/ordererOrganizations/harvest2home.com/ca"
  cp "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem" "${PWD}/organizations/ordererOrganizations/harvest2home.com/ca/ca.orderer.harvest2home.com-cert.pem"

  # Register the orderer identity
  echo "Registering orderer"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Register the user identity for the orderer org
  echo "Registering user1"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Register the orderer org admin
  echo "Registering org admin"
  set -x
  fabric-ca-client register --caname ca-orderer --id.name ordereradmin --id.secret ordereradminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Enroll the orderer to generate its MSP
  echo "Generating the orderer MSP"
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/msp" --csr.hosts orderer.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"

  # Ensure the MSP config file is properly copied for the orderer
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/msp/config.yaml"

  # Enroll the orderer to generate its TLS certificates
  echo "Generating the orderer TLS certificates"
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls" --enrollment.profile tls --csr.hosts orderer.harvest2home.com --csr.hosts localhost --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"
  
  # Move the TLS certs to the appropriate location
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/ca.crt"
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/signcerts/"* "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/server.crt"
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/keystore/"* "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/server.key"

  mkdir -p "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/msp/tlscacerts"
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/tls/tlscacerts/"* "${PWD}/organizations/ordererOrganizations/harvest2home.com/orderers/orderer.harvest2home.com/msp/tlscacerts/tlsca.harvest2home.com-cert.pem"

  # Enroll the user to generate its MSP
  echo "Generating the user MSP"
  fabric-ca-client enroll -u https://user1:user1pw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/harvest2home.com/users/User1@orderer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"

  # Ensure the MSP config file is properly copied for the user
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/harvest2home.com/users/User1@orderer.harvest2home.com/msp/config.yaml"

  # Enroll the org admin to generate its MSP
  echo "Generating the org admin MSP"
  fabric-ca-client enroll -u https://ordereradmin:ordereradminpw@localhost:9054 --caname ca-orderer -M "${PWD}/organizations/ordererOrganizations/harvest2home.com/users/Admin@orderer.harvest2home.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/orderer/ca-cert.pem"

  # Ensure the MSP config file is properly copied for the org admin
  cp "${PWD}/organizations/ordererOrganizations/harvest2home.com/msp/config.yaml" "${PWD}/organizations/ordererOrganizations/harvest2home.com/users/Admin@orderer.harvest2home.com/msp/config.yaml"
}


createFarmer
createDeliveryPartner
createConsumerAssosiation
createQualityAssuranceAgency
createOrderer
