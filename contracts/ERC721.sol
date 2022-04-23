pragma solidity ^0.8.0;

contract ERC721 {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenID
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 _tokenId
    );

    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovels;

    // Return the number of NFTs Assigned to an owner
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    // Find the owner of NFT
    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token Id does not exist");
        return owner;
    }

    //Enable or Desables an operator  to manage   all of message.senders assets.
    function setApprovalForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Check if an address is an operator for another address
    function isApprovedForAll(address owner, address operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[owner][operator];
    }

    // Updates and Approved addres for an NFT
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or an approved operator"
        );
        _tokenApprovels[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // Get the Approved Address for a  single NFT
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "Token ID does not exist !");
        return _tokenApprovels[tokenId];
    }

    // Transfer Ownership of an NFT
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        address owner = ownerOf(tokenId);

        require(
            msg.sender == owner ||
                getApproved(tokenId) == msg.sender ||
                isApprovedForAll(owner, msg.sender),
            "Msg.sender is not  the owner or approved for transfer "
        );

        require(owner == from, "From the netwro is not an owner !");

        require(to != address(0), "Address is zero !");

        require(_owners[tokenId] != address(0), "Token Id does not Exist !");

        approve(address(0), tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId];

        emit Transfer(from, to, tokenId);
    }

    // Standered transferFrom
    // Ckeck if onERC721 Recieved is implemented when sending Smart Ccontract
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implementd");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public {
        safeTransferFrom(from, to, tokenId, " ");
    }

    // Ovrsimplified
    function _checkOnERC721Received() private pure returns (bool) {
        return true;
    }
}

// EIP165 : Query if a contract implements another interface

function supportsInterface(bytes4 interfaceId) returns (bool) {
    return interfaceId == 0x80ac58cd;
}