// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {MockRenderer} from "test/mocks/MockRenderer.sol";

contract P5RendererTest is Test {
    function baseString() public pure returns (string memory) {
        return "";
    }

    function testTrue() public {
        MockRenderer renderer = new MockRenderer();
        renderer.render(0, "");
        assertTrue(true);
    }
}
