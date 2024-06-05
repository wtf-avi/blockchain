// SPDX-License-Identifier: MIT 

// importing the code form the chainlink to get the price of the ETH;

import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

pragma solidity >=0.5.0 <0.9.0;
/*
1--> Get funds from the user
2--> Withdraw funds
3--> Set a minimum funding value in usdt greater than the 1 ether
*/
 contract funding
 {
    
    // problem 1 - how to change the value of the etherum to the usdt
    uint minusdt=50 *1e18;

    //now to get the address of the people who are sending the money;

    address[] public funders;
    mapping(address=>uint) public addressToAmountFunded;

    function getfuds() public  payable 
    { 
    
         // if the funds are not greater than the deseried value then the function will reverted and the following msg of did not enough funds will pop up
        require(getconversion(msg.value)>= minusdt, "Didnot send the enough funds");
        funders.push(msg.sender);   
        addressToAmountFunded[msg.sender]=msg.value; 
    }
    function getprice() public view returns(uint)
    {
    // GETTING THE PRICE OF THE ETH IN THE USDT;
    AggregatorV3Interface pricefeed= AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
     (,int price,,,)=pricefeed.latestRoundData();
     return uint256(price * 1e10);
    }
    function getconversion(uint ethamount) public view returns(uint)
    {
        uint ethprice =getprice();
        uint ethusdt =(ethprice*ethamount) /1e18;
        return ethusdt;
    }
   }
   
