// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract RGBCollection is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 1000000;
    uint256 public constant MAX_PER_WALLET = 1000;
    uint256 private _nextTokenId;

    struct RGB {
        uint8 r;
        uint8 g;
        uint8 b;
    }

    mapping(uint256 => RGB) private _tokenColors;
    mapping(address => uint256) private _mintedCount;

    event ColorChanged(uint256 indexed tokenId, uint8 r, uint8 g, uint8 b);

    constructor(address initialOwner) ERC721("RGBCollection", "RGB") Ownable(initialOwner) {
        transferOwnership(initialOwner);
    }

    function mint(uint8 r, uint8 g, uint8 b) external {
        require(_nextTokenId < MAX_SUPPLY, "Max supply reached");
        require(_mintedCount[msg.sender] < MAX_PER_WALLET, "Mint limit per wallet reached");

        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
        _tokenColors[tokenId] = RGB(r, g, b);
        _mintedCount[msg.sender]++;

        emit ColorChanged(tokenId, r, g, b);
    }

    function bulkChangeColor(uint256[] calldata tokenIds, RGB[] calldata newColors) external {
        require(tokenIds.length == newColors.length, "Mismatched input lengths");

        for (uint256 i = 0; i < tokenIds.length; i++) {
            uint256 tokenId = tokenIds[i];
            require(ownerOf(tokenId) == msg.sender, "Not the owner of token");

            RGB memory newColor = newColors[i];
            _tokenColors[tokenId] = newColor;
            emit ColorChanged(tokenId, newColor.r, newColor.g, newColor.b);
        }
    }

    function getColor(uint256 tokenId) external view returns (uint8 r, uint8 g, uint8 b) {
        RGB memory color = _tokenColors[tokenId];
        return (color.r, color.g, color.b);
    }
}
