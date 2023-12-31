// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRendered {
    function baseString() external view returns (string memory);

    function tokenURI(uint256 _tokenId) external view returns (string memory);
}
