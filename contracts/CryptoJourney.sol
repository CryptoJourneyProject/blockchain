pragma solidity 0.5.0;

import "./ERC721Full.sol";
import "./AccessControl.sol";

contract CryptoJourney is AccessControl, ERC721Full {

    constructor() ERC721Full("CryptoJourney", "CJ") public {
        /// Starts paused.
        paused = true;

        /// The creator of the contract is the initial CEO
        setCEO(msg.sender);
    }

}