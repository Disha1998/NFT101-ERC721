pragma solidity ^0.8.0;
import "./ERC721.sol";

contract SuperMarioWorld is ERC721 {
    string public name; //ERC721Metadata
    string public symbol; //ERC721Metadata
    uint256 public tokenCount;

    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // Token URI -- Returns  a URL that points to the metadata/URI for where our metadata is stored

    function tokenURI(uint256 tokenID) public view returns (string memory) {
        //ERC721Metadata
        require(_owners[tokenID] != address(0), "Token I does not exist");
        return _tokenURIs[tokenID];
    }

    // mint -- Create a new nft inside out collection

    function mint(string memory _tokenURI) public {
        tokenCount += 1; //Token ID
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    // supportInterface

    function supportsInterface(bytes4 interfaceID) public pure returns (bool){
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;
    }
}
