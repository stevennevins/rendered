// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRenderer {
    function render(bytes calldata) external view returns (string memory);
}
