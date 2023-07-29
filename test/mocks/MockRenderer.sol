// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Renderer} from "src/Renderer.sol";

contract MockRenderer is Renderer {
    function render(bytes calldata data) external pure override returns (string memory) {
        return string(data);
    }
}
