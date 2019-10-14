pragma solidity ^0.5.12;

contract Reddit {
    uint public maxLength;
    
    struct _postContent {
        string contents;
        address senderAddress;
        uint timestamp;
  }
  
  _postContent[] Messages; 

  function postMessage(string memory _message)
    public {
    require(bytes(_message).length <= maxLength, "That message is too long.");
    Messages.push(_postContent(_message, msg.sender, block.timestamp));
  }
    
    constructor() public {
        postMessage("Hello World");
        maxLength = 280;
    }
    
    function setMaxLength(uint _maxLength) public {
        maxLength = _maxLength;
    }
    
    modifier checkValidIndex(uint i) {
        require(i < getMessageCount());
        require(i >= 0); _;
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
}