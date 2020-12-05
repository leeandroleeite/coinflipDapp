var contractAddress = "0x5baCa4CA05dE30474c4EdA81426533415AC2D528";
var contractInstance;
var account = "";

$(document).ready(async function(){


  if (window.ethereum) {
      window.web3 = new Web3(window.ethereum);
      try {
          // ask user for permission
          await window.ethereum.enable();
          // user approved permission
      } catch (error) {
          // user rejected permission
          console.log('user rejected permission');
      }
  }
  // Old web3 provider
  else if (window.web3) {
      window.web3 = new Web3(window.web3.currentProvider);

  }    // no need to ask for permission

  contractInstance = new web3.eth.Contract(abi, "0x5baCa4CA05dE30474c4EdA81426533415AC2D528");
  var accounts = await window.web3.eth.getAccounts();
  account = accounts [0];

  $("#heads").click(function() { coinSide = "Heads!"; });


  $("#tails").click(function() { coinSide = "Tails!"; });



  $("#placeBet").click(function() {

    if ($("#betAmount").val() < 1) {
      alert ("The minimum bet is 1 eth.");
    }
    else { sendBet(); }
  });

})



function sendBet () {
  var userPreference;
  var _Amount = $("#betAmount").val();
  _Amount = web3.utils.toWei(_Amount);

  if (confirm("Place bet?") == true) {

    contractInstance.methods.flip().send({from: account, gas: 30000, value: _Amount}).then( receipt => console.log(receipt) )

			userPreference = ("Bet has been placed. Please approve the transaction on your wallet.");
		} else {
			userPreference = ("Bet has not been placed");
    }
    alert (userPreference);
}
