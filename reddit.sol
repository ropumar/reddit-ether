pragma solidity ^0.5.12;

contract Reddit {
    uint public maxLength;
    
    struct _postStruct {
        string contents;
        address payable senderAddress;
        uint timestamp;
        uint votes;
    }
    _postStruct[] Messages; 
    
    constructor() public{
        maxLength = 280;
        postMessage("Hello World");
    }
 
    function postMessage(string memory _message) public{
        require(bytes(_message).length <= maxLength, "Message too long");
        Messages.push(_postStruct(_message, msg.sender, block.timestamp, 0));
    }
    

    function setMaxLength(uint _maxLength) public {
        maxLength = _maxLength;
    }
    
    modifier checkIndex(uint i) {
        require(i < getMessageCount());
        require(i >= 0); 
        _;
    }
    function getMessageCount()
        public view returns (uint) {
        return Messages.length;
    }

    function getMessageContents(uint i) checkIndex(i)
        public view returns (string memory) {
        return Messages[i].contents;
    }

    function getMessageAddress(uint i) checkIndex(i)
        public view returns (address) {
        return Messages[i].senderAddress;
    }

    function getMessageTimestamp(uint i) checkIndex(i)
        public view returns (uint) {
        return Messages[i].timestamp;
    }

    function getVotes(uint i) checkIndex(i)
        public view returns (uint) {
        return Messages[i].votes;
    }

    function payMessager(uint index) public payable{
        Messages[index].votes = Messages[index].votes + 1;
        Messages[index].senderAddress.transfer(1 ether);
    }
}