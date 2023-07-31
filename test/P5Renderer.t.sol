// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {P5Renderer} from "test/mocks/P5Renderer.sol";

contract P5RendererTest is Test {
    function testTrue() public {
        P5Renderer renderer = new P5Renderer(address(10));
        renderer.file();
        assertTrue(true);
    }
}
