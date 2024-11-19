const { contract } = require('fabric-contract-api');
const { ChaincodeStub } = require('fabric-shim');
const chai = require('chai');
const sinon = require('sinon');
const Harvest2Home = require('../lib/harvest2home');

const { expect } = chai;

describe('Harvest2Home Chaincode Tests', () => {
    let contract;
    let ctx;
    let stub;

    beforeEach(() => {
        contract = new Harvest2Home();
        stub = sinon.createStubInstance(ChaincodeStub);
        ctx = {
            stub,
            clientIdentity: {
                getMSPID: sinon.stub(),
                getID: sinon.stub(),
            }
        };
    });

    it('should allow farmer to add a product', async () => {
        ctx.clientIdentity.getMSPID.returns('FarmerMSP');
        ctx.clientIdentity.getID.returns('farmer1');
        stub.getState.resolves(Buffer.from(''));

        await contract.addProduct(ctx, 'product1', 'Apple', 'fruit', 100, 5);

        const expectedProduct = {
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Pending Approval',
            owner: 'farmer1',
        };
        expect(stub.putState.calledWith('product1', Buffer.from(JSON.stringify(expectedProduct)))).to.be.true;
    });

    it('should allow QA to approve a product', async () => {
        ctx.clientIdentity.getMSPID.returns('QualityAssuranceAgencyMSP');
        stub.getState.resolves(Buffer.from(JSON.stringify({
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Pending Approval',
        })));

        await contract.approveProduct(ctx, 'product1');

        const updatedProduct = {
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Approved',
        };
        expect(stub.putState.calledWith('product1', Buffer.from(JSON.stringify(updatedProduct)))).to.be.true;
    });

    it('should allow QA to reject a product', async () => {
        ctx.clientIdentity.getMSPID.returns('QualityAssuranceAgencyMSP');
        stub.getState.resolves(Buffer.from(JSON.stringify({
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Pending Approval',
        })));

        await contract.rejectProduct(ctx, 'product1', 'Poor quality');

        const rejectedProduct = {
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Rejected',
            comments: 'Poor quality',
        };
        expect(stub.putState.calledWith('product1', Buffer.from(JSON.stringify(rejectedProduct)))).to.be.true;
    });

    it('should allow consumer to place an order', async () => {
        ctx.clientIdentity.getMSPID.returns('ConsumersAssociationMSP');
        ctx.clientIdentity.getID.returns('consumer1');
        stub.getState.withArgs('product1').resolves(Buffer.from(JSON.stringify({
            name: 'Apple',
            category: 'fruit',
            quantity: 100,
            price: 5,
            status: 'Approved',
            owner: 'farmer1'
        })));
        stub.getState.withArgs('consumer1').resolves(Buffer.from(JSON.stringify({ balance: 500 })));
        stub.getState.withArgs('farmer1').resolves(Buffer.from(JSON.stringify({ balance: 100 })));

        await contract.placeOrder(ctx, 'order1', 'product1', 10);

        const updatedConsumer = { balance: 450 };
        const updatedFarmer = { balance: 150 };
        const updatedProduct = { quantity: 90, status: 'Approved' };

        expect(stub.putState.calledWith('consumer1', Buffer.from(JSON.stringify(updatedConsumer)))).to.be.true;
        expect(stub.putState.calledWith('farmer1', Buffer.from(JSON.stringify(updatedFarmer)))).to.be.true;
        expect(stub.putState.calledWith('product1', Buffer.from(JSON.stringify(updatedProduct)))).to.be.true;
    });

    it('should allow delivery partner to mark an order as delivered', async () => {
        ctx.clientIdentity.getMSPID.returns('DeliverypartnerMSP');
        ctx.clientIdentity.getID.returns('deliveryPartner1');
        stub.getState.withArgs('order1').resolves(Buffer.from(JSON.stringify({
            orderId: 'order1',
            productId: 'product1',
            quantity: 10,
            status: 'Pending Delivery',
            consumerId: 'consumer1'
        })));
        stub.getState.withArgs('product1').resolves(Buffer.from(JSON.stringify({
            owner: 'farmer1',
            tokens: 0,
        })));
        stub.getState.withArgs('deliveryPartner1').resolves(Buffer.from(JSON.stringify({ tokens: 0 })));

        await contract.deliverOrder(ctx, 'order1');

        const deliveredOrder = { status: 'Delivered' };
        const updatedFarmerTokens = { tokens: 10 };
        const updatedDeliveryPartnerTokens = { tokens: 5 };

        expect(stub.putState.calledWith('order1', Buffer.from(JSON.stringify(deliveredOrder)))).to.be.true;
        expect(stub.putState.calledWith('farmer1', Buffer.from(JSON.stringify(updatedFarmerTokens)))).to.be.true;
        expect(stub.putState.calledWith('deliveryPartner1', Buffer.from(JSON.stringify(updatedDeliveryPartnerTokens)))).to.be.true;
    });
});
