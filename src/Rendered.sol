// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRenderer} from "src/IRenderer.sol";
import {SSTORE2} from "sstore2/SSTORE2.sol";

abstract contract Rendered {
    address internal renderer;
    address internal baseURIPointer;

    mapping(uint256 => address) internal tokenDataPointer;

    function tokenURI(uint256 tokenId) external view returns (string memory) {
        address pointer = tokenDataPointer[tokenId];
        if (pointer == address(0)) return string(SSTORE2.read(baseURIPointer));
        return IRenderer(renderer).render(SSTORE2.read(pointer));
    }

    function _setRenderer(address _renderer) internal {
        renderer = _renderer;
    }

    function _setTokenData(uint256 _tokenId, bytes calldata _data) internal {
        address pointer = SSTORE2.write(_data);
        tokenDataPointer[_tokenId] = pointer;
    }

    function _setBaseURIData(bytes calldata _data) internal {
        address pointer = SSTORE2.write(_data);
        baseURIPointer = pointer;
    }
}
