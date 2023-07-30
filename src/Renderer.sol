// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRenderer} from "src/interfaces/IRenderer.sol";

/**
 * @title Renderer
 * @dev Abstract contract for rendering token metadata using a specified renderer.
 */
abstract contract Renderer is IRenderer {
    /**
     * @dev Renders the given data using the specified renderer.
     * @param _tokenId The ID of the data to render.
     * @param _data The data to render.
     * @return metadata The rendered token metadata as a string.
     */
    function render(uint256 _tokenId, bytes calldata _data) external view virtual returns (string memory metadata);
}
