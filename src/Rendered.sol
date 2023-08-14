// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRenderer} from "src/interfaces/IRenderer.sol";
import {IRendered} from "src/interfaces/IRendered.sol";
import {SSTORE2} from "sstore2/SSTORE2.sol";

/**
 * @title Rendered
 * @dev Abstract contract for rendering metadata of tokens.
 */
abstract contract Rendered {
    using SSTORE2 for address;
    using SSTORE2 for bytes;

    /**
     * @dev Address of the renderer contract.
     */
    address internal renderer;
    /**
     * @dev Address of the base string pointer.
     */
    address internal baseStringPointer;

    /**
     * @dev Mapping from token ID to address of the token data pointer.
     */
    mapping(uint256 => address) internal tokenDataPointers;
    
    /**
     * @dev Mapping from token ID to directly stored data.
     */
    mapping(uint256 => bytes) internal directTokenData;

    /**
     * @dev Emitted when the renderer contract is updated.
     * @param newRenderer The new address of the renderer contract.
     */
    event RendererUpdated(address indexed newRenderer);

    /**
     * @dev Initializes the Rendered contract with the address of the renderer.
     * @param _renderer The address of the renderer contract.
     */
    constructor(address _renderer, bytes memory _baseString) {
        renderer = _renderer;
        _setBaseString(_baseString);
    }

    /**
     * @notice Returns the base string for the token collection
     * @return The base string.
     */
    function baseString() external view returns (string memory) {
        return string(baseStringPointer.read());
    }

    /**
     * @notice Returns the URI of a specific token.
     * @param _tokenId The ID of the token.
     * @return The URI of the token as a string.
     */
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        if (directTokenData[_tokenId] > 0) {
            return IRenderer(renderer).render(_tokenId, directTokenData[_tokenId]);
        } else {
            address pointer = tokenDataPointers[_tokenId];
            return IRenderer(renderer).render(_tokenId, pointer.read());
        }
    }

    /**
     * @dev Sets the renderer contract address.
     * @param _renderer The address of the renderer contract.
     */
    function _setRenderer(address _renderer) internal {
        renderer = _renderer;
        emit RendererUpdated(_renderer);
    }

    /**
     * @dev Sets the token data for a specific token.
     * @param _tokenId The ID of the token.
     * @param _data The data to be set for the token.
     */
    function _setTokenData(uint256 _tokenId, bytes calldata _data) internal {
        if (_data.length > 0) {
            directTokenData[_tokenId] = _data;
        } else {
            address pointer = _data.write();
            tokenDataPointers[_tokenId] = pointer;
        }
    }

    /**
     * @dev Sets the base string data.
     * @param _data The base string data to be set.
     */
    function _setBaseString(bytes memory _data) internal {
        address pointer = _data.write();
        baseStringPointer = pointer;
    }
}
