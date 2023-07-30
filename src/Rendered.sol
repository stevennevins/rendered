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
     * @dev Address of the base URI pointer.
     */
    address internal baseURIPointer;

    /**
     * @dev Mapping from token ID to address of the token data pointer.
     */
    mapping(uint256 => address) internal tokenDataPointers;

    /**
     * @dev Emitted when the renderer contract is updated.
     * @param newRenderer The new address of the renderer contract.
     */
    event RendererUpdated(address indexed newRenderer);

    /**
     * @dev Initializes the Rendered contract with the address of the renderer.
     * @param _renderer The address of the renderer contract.
     */
    constructor(address _renderer, bytes memory _baseURI) {
        renderer = _renderer;
        _setBaseURIData(_baseURI);
    }

    /**
     * @notice Returns the base URI for the token collection
     * @return The base URI as a string.
     */
    function baseURI() external view returns (string memory) {
        return string(baseURIPointer.read());
    }

    /**
     * @notice Returns the URI of a specific token.
     * @param _tokenId The ID of the token.
     * @return The URI of the token as a string.
     */
    function tokenURI(uint256 _tokenId) external view returns (string memory) {
        address pointer = tokenDataPointers[_tokenId];
        return IRenderer(renderer).render(_tokenId, pointer.read());
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
        address pointer = _data.write();
        tokenDataPointers[_tokenId] = pointer;
    }

    /**
     * @dev Sets the base URI data.
     * @param _data The base URI data to be set.
     */
    function _setBaseURIData(bytes memory _data) internal {
        address pointer = _data.write();
        baseURIPointer = pointer;
    }
}
