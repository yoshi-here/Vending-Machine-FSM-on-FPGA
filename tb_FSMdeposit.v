////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_FSMdeposit.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description:This test bench purely tests the deposit module to see if it is incrementing the counter
// properly and also to indicate if exact change is necessary. 
//
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module tb_fsm_deposit;

reg CLOCK;
reg reset_n;
reg enable;
reg mode;
reg [1:0] coin_slot;
reg start_deposit;
reg [6:0] nick_count;
reg [6:0] dime_count;
wire [6:0] user_balance;
wire start_dispense;
wire exact_change;
wire will_user_get_change;
FSM_Deposit_yoshita dut(CLOCK, reset_n, enable, mode, coin_slot, start_deposit, nick_count, dime_count, user_balance, start_dispense, exact_change,will_user_get_change);


//clock
initial begin  
CLOCK = 0;
forever #10 CLOCK = ~CLOCK;
end


initial begin 
//intialize 
reset_n = 0; //press reset
enable = 0;
mode = 0;
coin_slot = 2'b00;
start_deposit = 0;


nick_count = 0;
dime_count = 0;

#20;
reset_n = 1; //release

//start deposit 

start_deposit = 1;
#20;
start_deposit = 0;


//insert nickel 
coin_slot = 2'b01;
enable = 1;
nick_count = 1;
#20;
enable = 0;
#20;

//insert dime
coin_slot = 2'b10;
enable = 1;
dime_count = 1;
#20;
enable = 0;
#20;

//insert dime
coin_slot = 2'b10;
enable = 1;
dime_count = 2;
#20;
enable = 0;
#20;

//insert dime
coin_slot = 2'b10;
enable = 1;
dime_count = 3;
#20;
enable = 0;
#20;

//switch to maintance mode
mode = 1;
//insert nickel 
coin_slot = 2'b01;
enable = 1;
nick_count = 2;
#20;
enable = 0;
#20;
          //this should not change the state
			 
//back to usermode			 
mode = 0;

//insert quarter 

coin_slot = 2'b11;
enable = 1;
#20;
enable = 0;
#20;



// exact change signal 

nick_count = 1;
dime_count = 0;
#20;
//high

nick_count = 4;
dime_count = 0;
#20;
//low

nick_count = 0;
dime_count = 2;
#20;
//low

//start deposit 

start_deposit = 1;
#20;
start_deposit = 0;

//testing the will user get change logic 
nick_count = 2;
dime_count = 2;
coin_slot = 2'b00;
#20

//insert quarter
coin_slot = 2'b11;
enable = 1;
#20;
enable = 0;
#20;
//insert quarter
coin_slot = 2'b11;
enable = 1;
#20;
enable = 0;
#20;
//insert quarter
coin_slot = 2'b11;
enable = 1;
#20;
enable = 0;
#20;


$stop;


end 

endmodule