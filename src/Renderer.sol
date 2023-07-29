// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRenderer} from "src/interfaces/IRenderer.sol";

abstract contract Renderer is IRenderer {
    function render(bytes calldata) external view virtual returns (string memory);
}
