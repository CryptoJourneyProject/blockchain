pragma solidity 0.5.0;

import "./ERC721Full.sol";
import "./AccessControl.sol";

contract CryptoJourney is AccessControl, ERC721Full {

    // using SafeMath32 for uint32;

    constructor() ERC721Full("CryptoJourney", "CJ") public {
        /// Starts paused.
        // paused = true;

        /// The creator of the contract is the initial owner
        setOwner(msg.sender);
    }

    uint normalPrice = 0.002 ether;

    function setNormalPrice(uint price) external onlyContractOwner {
        normalPrice = price;
    }

    struct Attraction {
        string name;
        int32 lang;
        int32 long;
        string image;
        uint price;
    }

    Attraction[] public attractions;

    function addAttraction(string calldata _name,
                           int32 _lang,
                           int32 _long,
                           string calldata _image) external onlyContractOwner returns (uint) {
        return attractions.push(Attraction({name: _name, lang: _lang, long: _long, image: _image, price: normalPrice})) - 1;
    }

    struct AttractionToken {
        string name;
        int32 lang;
        int32 long;
        string image;
    }

    AttractionToken[] attractionTokens;


    /// @dev A mapping from attraction token IDs to the address that owns them.
    mapping (uint256 => address) public attractionTokenIdToOwner;

    /// @dev A mapping from owner address to count of tokens that address owns.
    /// Used internally inside balanceOf() to resolve ownership count.
    mapping (address => uint256) ownershipTokenCount;

    /// @dev Assigns ownership of a specific attraction token to an address.
    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        // Since the number of attractions is capped to 2^32 we can't overflow this
        ownershipTokenCount[_to]++;
        // transfer ownership
        attractionTokenIdToOwner[_tokenId] = _to;
        // Emit the transfer event.
        emit Transfer(_from, _to, _tokenId);
    }


    /// @notice Returns all the relevant information about a specific attraction.
    /// @param _id The ID of the attraction of interest.
    function getAttractionToken(uint256 _id)
        external
        view
        returns (
        string memory name,
        int32 lang,
        int32 long,
        string memory image
    ) {
        AttractionToken storage attractionToken = attractionTokens[_id];

        name = attractionToken.name;
        lang = attractionToken.lang;
        long = attractionToken.long;
        image = attractionToken.image;
    }


    /// @dev An internal method that creates a new attraction token and stores it. This
    ///  method doesn't do any checking and should only be called when the
    ///  input data is known to be valid. Will generate a Transfer event.
    function _createAttractionToken(
        uint256 _attractionId,
        address _owner
    )
        internal
        returns (uint)
    {
        Attraction memory attraction = attractions[_attractionId];
        AttractionToken memory _attractionToken = AttractionToken({
            name: attraction.name,
            lang: attraction.lang,
            long: attraction.long,
            image: attraction.image
        });
        uint256 newAttractionTokenId = attractionTokens.push(_attractionToken) - 1;

        // It's probably never going to happen, 4 billion cats is A LOT, but
        // let's just be 100% sure we never let this happen.
        require(newAttractionTokenId == uint256(uint32(newAttractionTokenId)));


        // This will assign ownership, and also emit the Transfer event as
        // per ERC721 draft
        _transfer(address(0), _owner, newAttractionTokenId);

        return newAttractionTokenId;
    }

}