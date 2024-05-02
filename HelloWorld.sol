// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract HelloWorld {
  
  string public message;
  address private owner;

  constructor() {
    message = "Hello, world!";
    owner = msg.sender;
  }

  function displayMessage() public view returns(string memory) {
    return message;
  }

  function changeMessage(string memory newMessage) public {
    if (owner == msg.sender) { 
      message = newMessage;
    }
  }
}
