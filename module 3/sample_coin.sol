pragma solidity ^0.8.0;

contract sample_coin {

    // Introducing the maximum number of sample coins for sale
    uint public total_sample_coins = 1000000;

    // Introducing the USD to sample coin conversion rule
    uint public usd_to_sample_coin = 1000;

    // Introducing the total number of sample coins that have been bought by investors
    uint public total_sample_coin_bought = 0;

    // Mapping from the investor address to it's equity in sample coin and usd
    mapping(address => uint) equity_sample_coins;
    mapping(address => uint) equity_usd;

    // checking if an investor can buy sample coins
    modifier can_buy_sample_coin(uint usd_invested){
        require(usd_invested * usd_to_sample_coin + total_sample_coin_bought <= total_sample_coins);
        _;
    }

    // Getting the equity in sample_coins of an investor
    function equity_in_sample_coins(address investor) external view returns(uint){
        return equity_sample_coins[investor];
    }

    // Getting the equity in usd of an investor
    function equity_in_usd(address investor) external view returns(uint){
        return equity_usd[investor];
    }

    // Buying sample coins
    function buy_sample_coins(address investor, uint usd_invested) external
    can_buy_sample_coin(usd_invested) {
        uint sample_coin_bought = usd_invested * 1000;
        equity_sample_coins[investor] += sample_coin_bought;
        equity_usd[investor] += usd_invested;
        total_sample_coin_bought += sample_coin_bought;

    }

    // Selling sample coins
    function sell_sample_coins(address investor, uint sample_coin_sold) external {
        equity_sample_coins[investor] -= sample_coin_sold;
        equity_usd[investor] = equity_sample_coins[investor]/1000;
        total_sample_coin_bought -= sample_coin_sold;

    }

}
