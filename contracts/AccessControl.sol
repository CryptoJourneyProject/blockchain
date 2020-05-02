pragma solidity 0.5.0;

contract AccessControl {
    /// Emited when contract is upgraded - See README.md for updgrade plan
    event ContractUpgrade(address newContract);

    /// The addresses of the accounts (or contracts) that can execute actions.
    mapping (address => bool) public CEOs;

    /// Access modifier for CEO-only functionality
    modifier onlyCEO() {
        require(isCEO(msg.sender), "You must be CEO to perform this action");
        _;
    }

    /// Assigns a new address to act as the CEO. Only available to the current CEO.
    /// @param _ceoAddress The address of the new CEO
    function setCEO(address _newCeoAddress) external onlyCEO {
        require(_newCeoAddress != address(0), "Cannot set empty address to CEO");
        CEOs[_ceoAddress] = true;
    }

    /// Checks if an address belongs to a CEO.
    /// @param _address
    function isCEO(address _address) public returns (bool){
        return CEOs[_address];
    }
}