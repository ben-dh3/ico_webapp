// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.10;

  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";

  // Crypto Token Contract Address: 0x911731121Da7c0cE72f75A57f0AE8CC845625eAA

  contract CryptoToken is ERC20, Ownable {
    uint256 public constant tokenPrice = 0.001 ether;
    uint256 public constant maxTotalSupply = 10000 * 10**18;

    constructor() ERC20("Crypto Token", "CT"){}

    function mint(uint256 amount) public payable {
      uint256 _requiredAmount = tokenPrice * amount;
      require(msg.value >= _requiredAmount, "Ether sent is incorrect");
 
      uint256 amountWithDecimals = amount * 10**18;
      require(
          (totalSupply() + amountWithDecimals) <= maxTotalSupply,
          "Exceeds the max total supply available."
      );

      _mint(msg.sender, amountWithDecimals);
    }

    function withdraw() public onlyOwner {
      address _owner = owner();
      uint256 amount = address(this).balance;
      (bool sent, ) = _owner.call{value: amount}("");
      require(sent, "Failed to send Ether");
    }

    receive() external payable {}

    fallback() external payable {}
  }
