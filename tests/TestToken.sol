// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

import "@openzeppelin/contracts@3.4.0/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Test Token", "TT") public {
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return 12;
    }
}
