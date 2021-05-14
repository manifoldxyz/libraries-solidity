// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

/// @author: manifold.xyz

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./AdminControlCore.sol";

abstract contract AdminControlUpgradeable is AdminControlCore, OwnableUpgradeable {

    /**
     * @dev Only allows approved admins to call the specified function
     */
    modifier adminRequired() {
        require(_isAdmin(owner(), msg.sender), "AdminControl: Must be owner or admin");
        _;
    }   

    /**
     * @dev See {IAdminControlCore-isAdmin}.
     */
    function isAdmin(address admin) public override view returns (bool) {
        return _isAdmin(owner(), admin);
    }


    /**
     * @dev See {IAdminControlCore-approveAdmin}.
     */
    function approveAdmin(address admin) external override onlyOwner {
        _approveAdmin(admin);
    }

    /**
     * @dev See {IAdminControlCore-revokeAdmin}.
     */
    function revokeAdmin(address admin) external override onlyOwner {
        _revokeAdmin(admin);
    }

}