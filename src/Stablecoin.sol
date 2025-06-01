pragma solidity 0.8.20;

import "lib/openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract Stablecoin  is ERC20Upgradeable , OwnableUpgradeable{  
    function initialize(string memory name,string memory symbol) initializer public{
        __ERC20_init(name, symbol);
        __Ownable_init(msg.sender);
    }
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}
