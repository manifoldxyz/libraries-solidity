// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author: manifold.xyz

import "openzeppelin-solidity/contracts/utils/introspection/IERC165.sol";

/**
 * @dev Required interface of an ERC721Creator compliant extension contracts.
 */
interface IAdminControl is IERC165 {

    event AdminApproved(address indexed account, address indexed sender);
    event AdminRevoked(address indexed account, address indexed sender);

    /**
     * @dev gets address of all admins
     */
    function getAdmins() external view returns (address[] memory);

    /**
     * @dev add an admin.  Can only be called by contract owner.
     * Returns True if newly added, False if already added.
     */
    function approveAdmin(address admin) external returns (bool);

    /**
     * @dev remove an admin.  Can only be called by contract owner.
     * Returns True if removed, False if already removed.
     */
    function revokeAdmin(address admin) external returns (bool);

    /**
     * @dev checks whether or not given address is an admin
     * Returns True if they are
     */
    function isAdmin(address admin) external view returns (bool);

}