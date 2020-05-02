pragma solidity 0.5.0;

contract AccessControl {
    /// Emited when contract is upgraded - See README.md for updgrade plan
    event ContractUpgrade(address newContract);

    /// The addresses of the accounts (or contracts) that can execute actions.
    mapping (address => bool) public owners;

    /// Access modifier for owner-only functionality
    modifier onlyContractOwner() {
        require(isOwner(msg.sender), "You must be owner to perform this action");
        _;
    }

    /// Assigns a new address to act as an owner. Only available to the current owner.
    /// @param _newOwnerAddress The address of the new owner
    function setOwner(address _newOwnerAddress) public {
        require(_newOwnerAddress != address(0), "Cannot set empty address to owner");
        owners[_newOwnerAddress] = true;
    }

    /// Checks if an address belongs to an owner.
    /// @param _address of user
    function isOwner(address _address) public view returns (bool){
        return owners[_address];
    }
}