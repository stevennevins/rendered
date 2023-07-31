// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IFileStore} from "ethfs/packages/contracts/src/IFileStore.sol";
import {IRenderer} from "src/interfaces/IRenderer.sol";
import {IRendered} from "src/interfaces/IRendered.sol";
import {Base64} from "openzeppelin-contracts/contracts/utils/Base64.sol";

contract P5Renderer is IRenderer {
    address public fileStore;
    string public file = "p5-v1.5.0.min.js.gz";

    constructor(address _fileStore) {
        fileStore = _fileStore;
    }

    function render(uint256, bytes calldata data) external view returns (string memory) {
        return page(IRendered(msg.sender).baseString(), string(data));
    }

    function libraryPieces() internal view returns (string memory) {
        return string.concat(
            '<script type="text/javascript+gzip" src="data:text/javascript;base64,',
            IFileStore(fileStore).getFile(file).read(),
            '"></script>',
            '<script src="data:text/javascript;base64,',
            IFileStore(fileStore).getFile("gunzipScripts-0.0.1.js").read(),
            '"></script>'
        );
    }

    function script(string memory _scriptPiece, string memory _parameterPiece) internal pure returns (string memory) {
        return string.concat(
            '<script src="data:text/javascript;base64,',
            Base64.encode(abi.encodePacked(string.concat(_parameterPiece, _scriptPiece))),
            '"></script>'
        );
    }

    function page(string memory _scriptPiece, string memory _parameterPiece) internal view returns (string memory) {
        return string.concat(
            "data:text/html;base64,",
            Base64.encode(
                abi.encodePacked(
                    string.concat(
                        '<!DOCTYPE html><html style="height: 100%;"><body style="margin: 0;display: flex;justify-content: center;align-items: center;height: 100%;">',
                        libraryPieces(),
                        script(_scriptPiece, _parameterPiece),
                        "</body></html>"
                    )
                )
            )
        );
    }
}
