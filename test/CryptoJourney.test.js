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
            const c = await contract.addAttraction("Eiffel tower", -48000000, 170000000, "imageurl.com");
            console.log(c)
            const attractions = await contract.attractions();
            assert.equal(attractions, 1);
            assert.equal(attractions[0].name, "Eiffel tower");
            assert.equal(attractions[0].lang, -48000000);
            assert.equal(attractions[0].long, 170000000);
            assert.equal(attractions[0].image, "imageurl.com");
            assert.equal(attractions[0].price, 0.002);
        })
    })
})