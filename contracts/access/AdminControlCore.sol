// SPDX-License-Identifier: MIT

pragma solidity 0.8.3;

/// @author: manifold.xyz

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import "./IAdminControlCore.sol";

abstract contract AdminControlCore is IAdminControlCore, ERC165 {
    using EnumerableSet for EnumerableSet.AddressSet;

    // Track registered admins
    EnumerableSet.AddressSet private _admins;

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(IAdminControlCore).interfaceId
            || super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IAdminControlCore-getAdmins}.
     */
    function getAdmins() external view override returns (address[] memory admins) {
        admins = new address[](_admins.length());
        for (uint i = 0; i < _admins.length(); i++) {
            admins[i] = _admins.at(i);
        }
        return admins;
    }

    /**
     * Check if address is an admin or owner
     */
    function _isAdmin(address owner, address admin) internal view returns (bool) {
        return owner == admin || _admins.contains(admin);
    }

    /**
     * @dev Approve admin
     */
    function _approveAdmin(address admin) internal {
        if (!_admins.contains(admin)) {
            emit AdminApproved(admin, msg.sender);
            _admins.add(admin);
        }
    }

    /**
     * @dev Revoke admin
     */
    function _revokeAdmin(address admin) internal {
        if (_admins.contains(admin)) {
            emit AdminRevoked(admin, msg.sender);
            _admins.remove(admin);
        }
    }


}