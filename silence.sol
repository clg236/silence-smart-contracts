// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract SFTU {
    event Received(address _from, uint value);
    address public owner; // this is me, I can do certain things but really shouldn't need to...

    constructor(){
        owner = msg.sender;
        haterCount = 0;
    } 


    /*
        We use a data structure for Haters...
            id: just a counter for now, should probably rando it
            twitterid: this is the twitter id of the hater
            payoutAddress: if the hater posts an ethereum address, this will be here
            hasSTFU: has the hater stfu? this is only true if the payoutAddress is equal to the last tweet (for now)
            paid: has this particular id been paid? 
    */

    struct Haters {
        uint256 id;
        uint256 twitterid;
        address payable payoutAddress;
        uint256 bounty;
        bool hasSTFU;
        bool paid;
    }

    mapping(uint => Haters) public haters;

    uint256 haterCount;

    /*
        function: addHater(uint256 _id, uint256 _bounty)
        this function allows anyone to add a Hater by providing an id and a bounty
        the hater initially has the payout address set to whoever sends the bounty (so that they can get it back later)
    */

    function addHater(uint256 _twitterid, uint256 _bounty) public {
        haters[tripcount] = Hater(haterCount, _twitterid, payable(msg.sender), _bounty, false, false);
        haterCount++;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function haterSTFU(uint _twitterid) public {
        for (uint i=0; i < haters.length; i++) {
            if (haters[i].twitterid == _twitterid) {
                haters[i].hasSTFU = true;
            } 
        }
    }

    function payHater(uint256 _twitterid, address payable _address) public {
        // loop through the haters to find the one with the right id
        for (uint i=0; i < haters.length; i++) {
            if (haters[i].twitterid == _twitterid && haters[i].hasSTFU) {
                haters[i].payoutAddress = _address;
                _address.transfer(haters[i].bounty);
                haters[i].paid = true;
            } 
        }
    }

    function listHaters() public view returns (Haters[] memory) {
        Haters[] memory lhaters = new Haters[](tripcount);
        for (uint i =0; i < haterCount; i++) {
            Hater storage lhater = haters[];
            lhaters[i] = lhater;
        }
        return lhaters;
    }

    receive() external payable {
        // emit an payment event
    }

    fallback() external payable {
        // emit an fallback payment event
    }
}