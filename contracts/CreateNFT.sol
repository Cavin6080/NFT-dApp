// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CreateNFT {
    uint private tokenId = 0; 
    mapping (uint => string) private _tokenURIs;

    

    function createTokenURI(string memory _tokenURI) public returns (uint, string memory){
        _tokenURIs[tokenId] = _tokenURI;
        tokenId++;
        return(tokenId,_tokenURI);
    }

    function getTokenURI(uint _tId) public view returns (string memory){
        string memory _currentURI = _tokenURIs[_tId];
        return _currentURI;
    }

    function getAllTokenURIs() public view returns (string[] memory){
        string[] memory uris = new string[](tokenId);
        for(uint i =0;i<tokenId;i++){
            uris[i] = _tokenURIs[i];
        }
        return uris;
    }
}