// SPDX-License-Identifier: WTFPL

pragma solidity 0.6.12;


/**
 * @title ThousandXSWAP interface
 * @dev Interface of the ThousandXSWAP contract.
 * @dev see https://gitlab.com/musdasch/thousandxswap
 * @author Musdasch <musdasch@protonmail.com>
 */
interface IThousandXSWAP {
    /**
     * @dev Returns the base token address.
     */
    function getBaseToken() external view returns (address);

    /**
     * @dev Returns the liquidity pair of a token.
     */
    function getLiquidity(address token) external view returns (uint256, uint256);

    /**
     * @dev Returns the value of the amount of tokens the sender will receive if he calls the swap function.
     */
    function swapPreview(
        address tokenIn,
        address tokenOut,
        uint256 amountIn
    ) view external returns (uint256);

    /**
     * @dev Swaps the tokens.
     */
    function swap(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin
    ) external;

    /**
     * @dev Add liquidity to a token.
     */
    function addLiquidity(
        address token,
        uint256 tokenAmount,
        uint256 baseAmount
    ) external;

    /**
     * @dev Removes all liquidity from a token.
     */
    function removeLiquidity(address token) external;

    /**
     * @dev Gets called if as swap gets taken.
     */
    event newSWAP(
        address sender,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    /**
     * @dev Gets called if something changes on the liquidity without a swap.
     */
    event updateLiquidity(
        address token
    );
}
