////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    coin_counter.v
// Author:      Yoshita Papasani
// Date:        4/21/26
// Version:     4/21/26
// Description: The file is the register that handles the total amount of coins in the machine 
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module coin_counter(clock, reset_n, enable, mode, coin_slot,dispense_nick,dispense_dime, num_nick, num_dime, num_quat);

   input         clock;
	input         reset_n;
	input         enable;
	input         mode;
	input   [1:0] coin_slot;
	input         dispense_nick;
	input         dispense_dime;
	
	
	
	output reg [6:0] num_nick;
   output reg [6:0] num_dime;
	output reg [6:0] num_quat;
	
	 parameter N = 2'd1, D = 2'd2, Q =2'd3; //coin representation
	 
	 
	 
  //when reset is pressed, clears all coins in vending machine 
always @(posedge clock, negedge reset_n) begin
  
  if(reset_n == 1'b0) begin 
  num_nick <= 7'd0;
  num_dime <= 7'd0;
  num_quat <= 7'd0;
  end 
  
  //increments the counter when money is added
  else begin
  if (enable) begin
    if (coin_slot == N) num_nick <= num_nick + 7'd1;
    else if (coin_slot == D) num_dime <= num_dime + 7'd1;
    else if (coin_slot == Q) num_quat <= num_quat + 7'd1;
  
  end
  //decrements counter when money is dispensed
  else begin
  if (dispense_nick && num_nick > 0) begin 
  num_nick <= num_nick - 7'd1;
  
  end
  
  if(dispense_dime && num_dime > 0) begin 
  num_dime <= num_dime - 7'd1;
  
  end
  
end //
end
end
endmodule 









