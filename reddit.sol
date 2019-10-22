pragma solidity ^0.5.12;

contract Reddit {
    uint public maxLength;
    
    struct _postContent {
        string contents;
        address senderAddress;
        uint timestamp;
        uint votes;
    }
    _postContent[] Messages; 
    
    constructor() public {
        maxLength = 280;
        postMessage("Hello World");
    }
  

    function postMessage(string memory _message) public{
        require(bytes(_message).length <= maxLength, "Message too long");
        Messages.push(_postContent(_message, msg.sender, block.timestamp, 0));
    }
    

    function setMaxLength(uint _maxLength) public {
        maxLength = _maxLength;
    }
    
    modifier checkValidIndex(uint i) {
        require(i < getMessageCount());
        require(i >= 0); 
        _;
    }
    function getMessageCount()
        public view returns (uint) {
        return Messages.length;
    }

    function getMessageContents(uint i) checkValidIndex(i)
        public view returns (string memory) {
        return Messages[i].contents;
    }

    function getMessageAddress(uint i) checkValidIndex(i)
        public view returns (address) {
        return Messages[i].senderAddress;
    }

    function getMessageTimestamp(uint i) checkValidIndex(i)
        public view returns (uint) {
        return Messages[i].timestamp;
    }

    function getVotes(uint i) checkValidIndex(i)
        public view returns (uint) {
        return Messages[i].votes;
    }

    function payMessager(uint index) public payable returns (uint) {
        Messages[index].votes = Messages[index].votes + 1;
        Messages[index].senderAddress.transfer(1);
    }
}