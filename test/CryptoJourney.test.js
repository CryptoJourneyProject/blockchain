const CryptoJourney = artifacts.require("./CryptoJourney.sol")

require("chai").use(require("chai-as-promised")).should()

contract("CryptoJourney", (accounts) => {
    let contract;

    before(async() => {
        contract = await CryptoJourney.deployed({from: accounts[0]});
    })

    describe("deployment", async () => {
        it("deploys successfully", async () => {
            const address = contract.address;
            assert.notEqual(address, "");
            assert.notEqual(address, 0x0);
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
        })  

        it("has a name", async () => {
            const name = await contract.name();
            assert.equal(name, "CryptoJourney");
        })

        it("has a symbol", async () => {
            const symbol = await contract.symbol();
            assert.equal(symbol, "CJ");
        })
    })

    describe("define attractions", async () => {
        it("adds an attraction", async() => {
            await contract.addAttraction("Eiffel tower", -48000000, 170000000, "imageurl.com");
            const attraction = await contract.attractions.call(0);
            assert.equal(attraction.name, "Eiffel tower");
            assert.equal(attraction.lang, -48000000);
            assert.equal(attraction.long, 170000000);
            assert.equal(attraction.image, "imageurl.com");
            assert.equal(attraction.price, web3.utils.toWei('0.002', 'ether'));
        })
    })
})