pragma solidity ^0.8.3;
contract VestingContract{
   // IERC20 token1; 
   uint id;
   address owner;
    struct Person{
        uint amount;
        uint timeStamp;
        address add1;
    }
    //constructor(IERC20 _token1) public{
       // token1=_token1;
        
        
  //  }
  constructor()public{
      owner=msg.sender;
  }
    Person[] person;
    mapping(uint=>Person) public vestingDetails;
    modifier onlyOwner{
        (owner==msg.sender,"only owner have access");
        _;
    }

    function addVesting(uint _amount,address _add,uint _timeStamp) public onlyOwner{
        
        require(_timeStamp>=block.timestamp,"do not process");
        require(_amount>0,"not valid");
        require(_add!=address(0),"address invalid");

        Person memory person1=Person(_amount,_timeStamp,_add);
        vestingDetails[id]=person1;
        id++;
    }
    function releaseVesting(uint id) public {
        require(vestingDetails[id].timeStamp<=block.timestamp,"do not process");
     
     payable(vestingDetails[id].add1).transfer(vestingDetails[id].amount);

    }
    function releaseremainingBalance() public onlyOwner{
       payable(msg.sender).transfer(address(this).balance);

    }
    receive() external payable {}
}
