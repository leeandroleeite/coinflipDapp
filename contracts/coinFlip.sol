pragma solidity 0.5.12;

contract CoinFlip {

    // STATE VARIABLES

    uint pool;
    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    // EVENTS

    event bet(address user, uint bet, bool);
    event funded(address owner, uint amount);


    // MODIFIERS

    modifier onlyOwner(){
        require(msg.sender == owner, "Unauthorized operation. You are not the contract owner.");
        _;
    }

    // GET USER BALANCE

    function balance() public view returns (uint) {
        return (address(this).balance);
    }


    //CoinFlip Mechanics

    function flip() public payable returns (bool){
        require (address(this).balance >= msg.value, "Insuficient funds.");
        require (msg.value >= 0.1 ether, "Minimum bet is 0.1 ETH.");
        bool result;

        if (now % 2 == 0){
            result = false;
            pool += msg.value;
        }else if(now % 2 == 1){
            result = true;
            pool -= msg.value;
            msg.sender.transfer(msg.value*2);
        }

        if (now % 2 == 0){
            result = false;
            pool += msg.value;
        }else if(now % 2 == 1){
            result = true;
            pool -= msg.value;
            msg.sender.transfer(msg.value*2);
        }



        emit bet(msg.sender, msg.value, result);
        return result;
    }

    // FUND

    function fund() public onlyOwner payable returns (uint){
        require(msg.value >= 1 ether);
        pool += msg.value;

        assert(pool == address(this).balance);
        emit funded(msg.sender, msg.value);
        return msg.value;
    }

    // WITHDRAW

    function withdraw() public onlyOwner returns (uint){
        msg.sender.transfer(address(this).balance);
        return address(this).balance;
    }

}
