// SPDX-License-Identifier: WTFPL

pragma solidity 0.6.12;

import "@openzeppelin/contracts@3.4.0/access/Ownable.sol";
import "@openzeppelin/contracts@3.4.0/math/SafeMath.sol";
import "@openzeppelin/contracts@3.4.0/token/ERC20/IERC20.sol";

import "./ISWAP.sol";

contract SWAP is Ownable, SWAP {

    address private _baseToken;

    mapping(address => uint256) private _liquidity;

    constructor(address baseToken)
        public
    {
        _baseToken = baseToken;
    }

    function getBaseToken()
        public
        view
        virtual
        override
        returns (address)
    {
        return _baseToken;
    }

    function getLiquidity(address token)
        public
        view
        virtual
        override
        returns (uint256, uint256)
    {
        require(
            token != _baseToken,
            "Token can't be base Token"
        );
        
        IERC20 tokenIERC20 = IERC20(token);
        uint256 tokenBalance = tokenIERC20.balanceOf(address(this));
        uint256 baseTokenBalance = _liquidity[token];
        return (tokenBalance, baseTokenBalance);
    }

    function swapPreview(
        address tokenIn,
        address tokenOut,
        uint256 amountIn
    )
        view
        public
        virtual
        override
        returns (uint256)
    {

        if(tokenIn != _baseToken)
        {
            amountIn = toBaseToken(tokenIn, amountIn);
        }

        if(tokenOut != _baseToken)
        {
            amountIn = fromBaseToken(tokenOut, amountIn);
        }

        return amountIn;
    }

    function swap(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin
    )
        public
        virtual
        override
    {
        require(
            amountOutMin >= swapPreview(tokenIn, tokenOut, amountIn),
            "Swap is not posible. Requestet amount is to less."
        );

        IERC20 tokenInIERC20 = IERC20(tokenIn);
        IERC20 tokenOutIERC20 = IERC20(tokenOut);

        uint256 in_ = 0;
        uint256 out_ = 0;

        in_ = amountIn;
        
        if(tokenIn != _baseToken)
        {
            amountIn = toBaseToken(tokenIn, amountIn);
            _liquidity[tokenIn] = SafeMath.sub(_liquidity[tokenIn], amountIn);

            if(tokenOut == _baseToken)
            {
                out_ =  amountIn;
            }
        }

        if(tokenOut != _baseToken)
        {
            out_ = fromBaseToken(tokenOut, amountIn);
            _liquidity[tokenOut] = SafeMath.add(_liquidity[tokenOut], amountIn);
        }

        emit newSWAP(
            msg.sender,
            tokenIn,
            tokenOut,
            in_,
            out_
        );

        tokenInIERC20.transferFrom(msg.sender, address(this), in_);
        tokenOutIERC20.transfer(msg.sender, out_);
    }

    
    function addLiquidity(address token, uint256 tokenAmount, uint256 baseAmount)
        public
        virtual
        override
        onlyOwner
    {
        require(
            token != _baseToken,
            "Token can't be base Token"
        );

        IERC20 tokenIERC20 = IERC20(token);
        IERC20 baseIERC20 = IERC20(_baseToken);

        _liquidity[token] = SafeMath.add(_liquidity[token], baseAmount);

        emit updateLiquidity(token);

        tokenIERC20.transferFrom(msg.sender, address(this), tokenAmount);
        baseIERC20.transferFrom(msg.sender, address(this), baseAmount);
    }

    function removeLiquidity(address token)
        public
        virtual
        override
        onlyOwner
    {
        require(
            token != _baseToken,
            "Token can't be base Token"
        );

        IERC20 tokenIERC20 = IERC20(token);
        IERC20 baseIERC20 = IERC20(_baseToken);

        uint256 tokenOut = tokenIERC20.balanceOf(address(this));
        uint256 baseOut = _liquidity[token];
        _liquidity[token] = 0;

        emit updateLiquidity(token);
        
        tokenIERC20.transfer(owner(), tokenOut);
        baseIERC20.transfer(owner(), baseOut);
    }

    function fromBaseToken(address tokenOut, uint256 amountIn)
        view
        private
        returns (uint256)
    {
        IERC20 token = IERC20(tokenOut);

        require(
            0 < _liquidity[tokenOut],
            "There is no liquidity."
        );

        require(
            0 < token.balanceOf(address(this)),
            "There is no liquidity."
        );

        uint256 newTotal = SafeMath.add(amountIn, _liquidity[tokenOut]);
        uint256 dividend = SafeMath.mul(amountIn, token.balanceOf(address(this)));
        uint256 amount = SafeMath.div(dividend, newTotal);

        //Tax
        if(SafeMath.div(amount, 1000) == 0) {
            amount = SafeMath.sub(amount, 1);
        } else {
            amount = SafeMath.sub(amount, SafeMath.div(amount, 1000));
        }

        return amount;
    }

    function toBaseToken(address tokenIn, uint256 amountIn)
        view
        private
        returns (uint256)
    {
        IERC20 token = IERC20(tokenIn);

        require(
            0 < token.balanceOf(address(this)),
            "There is no liquidity."
        );

        require(
            0 < _liquidity[tokenIn],
            "There is no liquidity."
        );

        uint256 newTotal = SafeMath.add(amountIn, token.balanceOf(address(this)));
        uint256 dividend = SafeMath.mul(amountIn, _liquidity[tokenIn]);
        uint256 amount = SafeMath.div(dividend, newTotal);

        //Tax
        if(SafeMath.div(amount, 1000) == 0){
            amount = SafeMath.sub(amount, 1);
        } else {
            amount = SafeMath.sub(amount, SafeMath.div(amount, 1000));
        }
        
        return amount;
    }
}
