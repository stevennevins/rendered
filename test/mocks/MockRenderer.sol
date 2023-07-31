// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Renderer} from "src/Renderer.sol";
import {IRendered} from "src/interfaces/IRendered.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

contract MockRenderer is Renderer {
    using Strings for uint256;

    function render(uint256 _tokenId, bytes calldata) external view override returns (string memory) {
        /// this renderer expects there to be no token data, and builds a url based on the base URI
        return string.concat(IRendered(msg.sender).baseString(), _tokenId.toString());
    }
}
