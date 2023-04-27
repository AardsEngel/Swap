// SPDX-License-Identifier: GPL-3.0
    
pragma solidity 0.6.12;

import "remix_tests.sol"; 
import "remix_accounts.sol";

import "@openzeppelin/contracts@3.4.0/token/ERC20/IERC20.sol";

import "../contracts/SWAP.sol";
import "../contracts/ISWAP.sol";
import "./TestToken.sol";

contract testSuite {
    IERC20 token1;
    IERC20 token2;
    IERC20 token3;
    IERC20 token4;

    IERC20 baseToken;

    ISWAP swap;
    SWAP tswap;


    function beforeAll() public {

        token1 = new TestToken(1000000);
        token2 = new TestToken(1000000);
        token3 = new TestToken(1000000);
        token4 = new TestToken(1000000);
        
        baseToken = new TestToken(1000000);

        tswap = new SWAP(address(baseToken)); 
        swap = tswap;
    }

    function tokenValues() public {

        Assert.equal(token1.balanceOf(address(this)), 1000000, "Invalid balance of token 1");
        Assert.equal(token2.balanceOf(address(this)), 1000000, "Invalid balance of token 2");
        Assert.equal(token3.balanceOf(address(this)), 1000000, "Invalid balance of token 3");
        Assert.equal(token4.balanceOf(address(this)), 1000000, "Invalid balance of token 4");

        Assert.equal(baseToken.balanceOf(address(this)), 1000000, "Invalid balance of base token");
    }

    function testGetBaseToken() public {
        Assert.equal(swap.getBaseToken(), address(baseToken), "Base Token is not equals to base token of swap contract.");
    }

    function testInitLiquidity() public {
        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 0, "Inital Liquidity should be 0.");
        Assert.equal(baseToken1Liquidity, 0, "Inital Liquidity should be 0.");
    }
    
    function testAddLiquidity1() public {
        token1.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token1), 2000, 1000);

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));

        Assert.equal(token1Liquidity, 2000, "Liquidity should be 1000.");
        Assert.equal(baseToken1Liquidity, 1000, "Liquidity should be 1000.");
        
        Assert.equal(token1.balanceOf(address(this)), 998000, "Balance of token 1 should be 998000.");
        Assert.equal(baseToken.balanceOf(address(this)), 999000, "Balance of base token should be 999000.");
    }

    function testAddLiquidity2() public {
        token2.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token2), 2000, 1000);

        (uint256 token2Liquidity, uint256 baseToken2Liquidity) = swap.getLiquidity(address(token2));

        Assert.equal(token2Liquidity, 2000, "Liquidity should be 1000.");
        Assert.equal(baseToken2Liquidity, 1000, "Liquidity should be 1000.");
        
        Assert.equal(token2.balanceOf(address(this)), 998000, "Balance of token 2 should be 998000.");
        Assert.equal(baseToken.balanceOf(address(this)), 998000, "Balance of base token should be 998000.");
    }

    function testAddLiquidity3() public {
        token3.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token3), 2000, 1000);

        (uint256 token3Liquidity, uint256 baseToken3Liquidity) = swap.getLiquidity(address(token3));

        Assert.equal(token3Liquidity, 2000, "Liquidity should be 1000.");
        Assert.equal(baseToken3Liquidity, 1000, "Liquidity should be 1000.");
        
        Assert.equal(token3.balanceOf(address(this)), 998000, "Balance of token 3 should be 998000.");
        Assert.equal(baseToken.balanceOf(address(this)), 997000, "Balance of base token should be 997000.");
    }

    function testAddLiquidity4() public {
        token4.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token4), 2000, 1000);

        (uint256 token4Liquidity, uint256 baseToken4Liquidity) = swap.getLiquidity(address(token3));

        Assert.equal(token4Liquidity, 2000, "Liquidity should be 1000.");
        Assert.equal(baseToken4Liquidity, 1000, "Liquidity should be 1000.");
        
        Assert.equal(token4.balanceOf(address(this)), 998000, "Balance of token 4 should be 998000.");
        Assert.equal(baseToken.balanceOf(address(this)), 996000, "Balance of base token should be 998000.");
    }

    
    function reTestAddLiquidity1() public {
        token1.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token1), 2000, 1000);

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));

        Assert.equal(token1Liquidity, 4000, "Liquidity should be 4000.");
        Assert.equal(baseToken1Liquidity, 2000, "Liquidity should be 2000.");
        
        Assert.equal(token1.balanceOf(address(this)), 996000, "Balance of token 1 should be 996000.");
        Assert.equal(baseToken.balanceOf(address(this)), 995000, "Balance of base token should be 995000.");
    }

    function reTestAddLiquidity2() public {
        token2.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token2), 2000, 1000);

        (uint256 token2Liquidity, uint256 baseToken2Liquidity) = swap.getLiquidity(address(token2));

        Assert.equal(token2Liquidity, 4000, "Liquidity should be 4000.");
        Assert.equal(baseToken2Liquidity, 2000, "Liquidity should be 2000.");
        
        Assert.equal(token2.balanceOf(address(this)), 996000, "Balance of token 2 should be 996000.");
        Assert.equal(baseToken.balanceOf(address(this)), 994000, "Balance of base token should be 994000.");
    }

    function reTestAddLiquidity3() public {
        token3.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token3), 2000, 1000);

        (uint256 token3Liquidity, uint256 baseToken3Liquidity) = swap.getLiquidity(address(token3));

        Assert.equal(token3Liquidity, 4000, "Liquidity should be 4000.");
        Assert.equal(baseToken3Liquidity, 2000, "Liquidity should be 2000.");
        
        Assert.equal(token3.balanceOf(address(this)), 996000, "Balance of token 3 should be 996000.");
        Assert.equal(baseToken.balanceOf(address(this)), 993000, "Balance of base token should be 993000.");
    }

    function reTestAddLiquidity4() public {
        token4.approve(address(swap), 2000);
        baseToken.approve(address(swap), 1000);

        swap.addLiquidity(address(token4), 2000, 1000);

        (uint256 token4Liquidity, uint256 baseToken4Liquidity) = swap.getLiquidity(address(token4));

        Assert.equal(token4Liquidity, 4000, "Liquidity should be 4000.");
        Assert.equal(baseToken4Liquidity, 2000, "Liquidity should be 2000.");
        
        Assert.equal(token4.balanceOf(address(this)), 996000, "Balance of token 3 should be 996000.");
        Assert.equal(baseToken.balanceOf(address(this)), 992000, "Balance of base token should be 992000.");
    }

    function testAddBigLiquidity() public {
        token1.approve(address(swap), 200000);
        baseToken.approve(address(swap), 100000);
        swap.addLiquidity(address(token1), 200000, 100000); // New Total 204000 to 102000

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 204000, "Liquidity should be 204000.");
        Assert.equal(baseToken1Liquidity, 102000, "Liquidity should be 102000.");

        token2.approve(address(swap), 200000);
        baseToken.approve(address(swap), 100000);
        swap.addLiquidity(address(token2), 200000, 100000); // New Total 204000 to 102000

        (uint256 token2Liquidity, uint256 baseToken2Liquidity) = swap.getLiquidity(address(token2));
        Assert.equal(token2Liquidity, 204000, "Liquidity should be 204000.");
        Assert.equal(baseToken2Liquidity, 102000, "Liquidity should be 102000.");

        token3.approve(address(swap), 200000);
        baseToken.approve(address(swap), 100000);
        swap.addLiquidity(address(token3), 200000, 100000); // New Total 204000 to 102000

        (uint256 token3Liquidity, uint256 baseToken3Liquidity) = swap.getLiquidity(address(token3));
        Assert.equal(token3Liquidity, 204000, "Liquidity should be 204000.");
        Assert.equal(baseToken3Liquidity, 102000, "Liquidity should be 102000.");

        token4.approve(address(swap), 200000);
        baseToken.approve(address(swap), 100000);
        swap.addLiquidity(address(token4), 200000, 100000); // New Total 204000 to 102000

        (uint256 token4Liquidity, uint256 baseToken4Liquidity) = swap.getLiquidity(address(token4));
        Assert.equal(token4Liquidity, 204000, "Liquidity should be 204000.");
        Assert.equal(baseToken4Liquidity, 102000, "Liquidity should be 102000.");
    }

    function testSwapPreview() public {
        Assert.equal(swap.swapPreview(address(token1), address(baseToken), 1000), 496, "Shuld resive 496 base tokens.");
        Assert.equal(swap.swapPreview(address(token1), address(baseToken), 5000), 2438, "Shuld resive 2438 base tokens.");

        Assert.equal(swap.swapPreview(address(baseToken), address(token1), 100), 198, "Shuld resive 198 tokens.");
        Assert.equal(swap.swapPreview(address(baseToken), address(token2), 1000), 1979, "Shuld resive 1979 tokens.");

        Assert.equal(swap.swapPreview(address(token1), address(token2), 1000), 986, "Shuld resive 664 base tokens.");
        Assert.equal(swap.swapPreview(address(token2), address(token1), 1000), 986, "Shuld resive 664 base tokens.");

        Assert.equal(swap.swapPreview(address(token1), address(token2), 5000), 4758, "Shuld resive 4758 base tokens.");
        Assert.equal(swap.swapPreview(address(token2), address(token1), 5000), 4758, "Shuld resive 4758 base tokens.");
    }

    function testSwap() public {
        Assert.equal(token1.balanceOf(address(this)), 796000, "Balance of token 1 should be 796000.");
        Assert.equal(token2.balanceOf(address(this)), 796000, "Balance of token 2 should be 796000.");
        Assert.equal(token3.balanceOf(address(this)), 796000, "Balance of token 3 should be 796000.");
        Assert.equal(token4.balanceOf(address(this)), 796000, "Balance of token 4 should be 796000.");
        Assert.equal(baseToken.balanceOf(address(this)), 592000, "Balance of base token should be 592000.");

        token1.approve(address(swap), 5000);
        
        uint256 getAmount = swap.swapPreview(address(token1), address(baseToken), 5000);
        uint256 beforeAmount = baseToken.balanceOf(address(this));
        
        swap.swap(address(token1), address(baseToken), 5000, getAmount);

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 209000, "Liquidity should be 209000.");
        Assert.equal(baseToken1Liquidity, 99562, "Liquidity should be 2000.");

        Assert.equal(token1.balanceOf(address(this)), 791000, "Balance of token 1 should be 791000.");
        Assert.equal(baseToken.balanceOf(address(this)), 594438, "Balance of base token should be 594438.");
        
        Assert.equal(baseToken.balanceOf(address(this)), getAmount+beforeAmount, "1: Should be getAmount+beforeAmount.");

        baseToken.approve(address(swap), 1000);

        getAmount = swap.swapPreview(address(baseToken), address(token2), 1000);
        beforeAmount = token2.balanceOf(address(this));

        swap.swap(address(baseToken), address(token2), 1000, getAmount);

        (uint256 token2Liquidity, uint256 baseToken2Liquidity) = swap.getLiquidity(address(token2));
        Assert.equal(token2Liquidity, 202021, "Liquidity should be 202021.");
        Assert.equal(baseToken2Liquidity, 103000, "Liquidity should be 103000.");

        Assert.equal(token2.balanceOf(address(this)), 797979, "Balance of token 2 should be 797979.");
        Assert.equal(baseToken.balanceOf(address(this)), 593438, "Balance of base token should be 593438.");

        Assert.equal(token2.balanceOf(address(this)), getAmount+beforeAmount, "2: Should be getAmount+beforeAmount.");

        token3.approve(address(swap), 5000);

        getAmount = swap.swapPreview(address(token3), address(token4), 5000);
        beforeAmount = token4.balanceOf(address(this));

        swap.swap(address(token3), address(token4), 5000, getAmount);

        (uint256 token3Liquidity, uint256 baseToken3Liquidity) = swap.getLiquidity(address(token3));
        Assert.equal(token3Liquidity, 209000, "Liquidity should be 209000.");
        Assert.equal(baseToken3Liquidity, 99562, "Liquidity should be 99562.");

        (uint256 token4Liquidity, uint256 baseToken4Liquidity) = swap.getLiquidity(address(token4));
        Assert.equal(token4Liquidity, 199242, "Liquidity should be 199242.");
        Assert.equal(baseToken4Liquidity, 104438, "Liquidity should be 2000.");

        Assert.equal(token3.balanceOf(address(this)), 791000, "Balance of token 3 should be 791000.");
        Assert.equal(token4.balanceOf(address(this)), 800758, "Balance of token 4 should be 800758.");

        Assert.equal(token4.balanceOf(address(this)), getAmount+beforeAmount, "3: Should be getAmount+beforeAmount.");
    }

    function testRemoveLiquidity() public {
        swap.removeLiquidity(address(token1));
        swap.removeLiquidity(address(token2));
        swap.removeLiquidity(address(token3));
        swap.removeLiquidity(address(token4));

        Assert.equal(token1.balanceOf(address(this)), 1000000, "Balance of token 3 should be 1000000.");
        Assert.equal(token2.balanceOf(address(this)), 1000000, "Balance of token 3 should be 1000000.");
        Assert.equal(token3.balanceOf(address(this)), 1000000, "Balance of token 3 should be 1000000.");
        Assert.equal(token4.balanceOf(address(this)), 1000000, "Balance of token 3 should be 1000000.");

        Assert.equal(baseToken.balanceOf(address(this)), 1000000, "Balance of token 3 should be 1000000.");

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 0, "Liquidity should be 0.");
        Assert.equal(baseToken1Liquidity, 0, "Liquidity should be 0.");

        (uint256 token2Liquidity, uint256 baseToken2Liquidity) = swap.getLiquidity(address(token2));
        Assert.equal(token2Liquidity, 0, "Liquidity should be 0.");
        Assert.equal(baseToken2Liquidity, 0, "Liquidity should be 0.");

        (uint256 token3Liquidity, uint256 baseToken3Liquidity) = swap.getLiquidity(address(token3));
        Assert.equal(token3Liquidity, 0, "Liquidity should be 0.");
        Assert.equal(baseToken3Liquidity, 0, "Liquidity should be 0.");

        (uint256 token4Liquidity, uint256 baseToken4Liquidity) = swap.getLiquidity(address(token4));
        Assert.equal(token4Liquidity, 0, "Liquidity should be 0.");
        Assert.equal(baseToken4Liquidity, 0, "Liquidity should be 0.");
    }

    function testSwapNoLiquidity() public {

        token1.approve(address(swap), 200000);
        baseToken.approve(address(swap), 100000);
        swap.addLiquidity(address(token1), 200000, 100000); // New Total 200000 to 100000

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 200000, "Liquidity should be 200000.");
        Assert.equal(baseToken1Liquidity, 100000, "Liquidity should be 100000.");
        
        token1.approve(address(swap), 5000);
        uint256 getAmount = swap.swapPreview(address(token1), address(baseToken), 5000);
        swap.swap(address(token1), address(baseToken), 5000, getAmount);

        Assert.equal(token1.balanceOf(address(this)), 795000, "Balance of token 1 should be 795000.");
        Assert.equal(baseToken.balanceOf(address(this)), 902437, "Balance of base token should be 902437.");

        baseToken.approve(address(swap), 1000);

        try swap.swap(address(baseToken), address(token2), 1000, 1000) {
            Assert.ok(false, "swap should not be executed without error.");
        } catch Error(string memory error) {
            Assert.equal(error, "There is no liquidity.", "Wrong message.");
        } catch (bytes memory) {
            Assert.ok(false, "swap failed unexpected");
        }

        token2.approve(address(swap), 1000);

        try swap.swap(address(token2), address(baseToken), 1000, 1000) {
            Assert.ok(false, "swap should not be executed without error.");
        } catch Error(string memory error) {
            Assert.equal(error, "There is no liquidity.", "Wrong message.");
        } catch (bytes memory) {
            Assert.ok(false, "swap failed unexpected");
        }

        swap.removeLiquidity(address(token1));
        (token1Liquidity, baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 0, "Liquidity should be 0.");
        Assert.equal(baseToken1Liquidity, 0, "Liquidity should be 0.");

    }

    function testIllegalAddLiquidity() public {
        baseToken.approve(address(swap), 1000);
        baseToken.approve(address(swap), 1000);

        try swap.getLiquidity(address(baseToken)) {
            Assert.ok(false, "getLiquidity should not be executed without error.");
        } catch Error(string memory error) {
            Assert.equal(error, "Token can't be base Token", "Test");
        } catch (bytes memory) {
            Assert.ok(false, "getLiquidity failed unexpected");
        }

        try swap.addLiquidity(address(baseToken), 1000, 1000) {
            Assert.ok(false, "addLiquidity should not be executed without error.");
        } catch Error(string memory error) {
            Assert.equal(error, "Token can't be base Token", "Test");
        } catch (bytes memory) {
            Assert.ok(false, "addLiquidity failed unexpected");
        }
        
        Assert.equal(baseToken.balanceOf(address(this)), 1000000, "Balance of base token should be 1000000.");
    }

    function testIllegalRemoveLiquidity() public {
        token1.approve(address(swap), 1);
        baseToken.approve(address(swap), 1);
        swap.addLiquidity(address(token1), 1, 1);

        try swap.removeLiquidity(address(baseToken)) {
            Assert.ok(false, "removeLiquidity should not be executed without error.");
        } catch Error(string memory error) {
            Assert.equal(error, "Token can't be base Token", "Test");
        } catch (bytes memory) {
            Assert.ok(false, "removeLiquidity failed unexpected");
        }
        
        Assert.equal(token1.balanceOf(address(this)), 999999, "Balance of token 3 should be 999999.");
        Assert.equal(baseToken.balanceOf(address(this)), 999999, "Balance of token 3 should be 999999.");
    }

    function testOnlyOwner() public {
        tswap.transferOwnership(TestsAccounts.getAccount(0));

        try swap.removeLiquidity(address(token1)) {
            Assert.ok(false, "removeLiquidity should not be executed without error.");
        } catch Error(string memory) {
            Assert.ok(true, "removeLiquidity failed with reason.");
        } catch (bytes memory) {
            Assert.ok(false, "removeLiquidity failed unexpected");
        }

        token1.approve(address(swap), 1);
        baseToken.approve(address(swap), 1);

        try swap.addLiquidity(address(token1), 1, 1) {
            Assert.ok(false, "addLiquidity should not be executed without error.");
        } catch Error(string memory) {
            Assert.ok(true, "addLiquidity failed with reason");
        } catch (bytes memory) {
            Assert.ok(false, "addLiquidity failed unexpected");
        }

        Assert.equal(token1.balanceOf(address(this)), 999999, "Balance of token 3 should be 999999.");
        Assert.equal(baseToken.balanceOf(address(this)), 999999, "Balance of token 3 should be 999999.");

        (uint256 token1Liquidity, uint256 baseToken1Liquidity) = swap.getLiquidity(address(token1));
        Assert.equal(token1Liquidity, 1, "Liquidity should be 1.");
        Assert.equal(baseToken1Liquidity, 1, "Liquidity should be 1.");
    }
}
