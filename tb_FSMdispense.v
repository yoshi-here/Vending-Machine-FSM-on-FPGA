////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_FSMdispense.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description:This test bench tests the combined module of dispense fsm and the timer module to see if 
//             both are working correctly in tandem.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns
module tb_FSMdispense();

reg         clk;
reg         reset_n;
reg      [6:0]user_balance;
reg         start_dispense;

reg         will_user_get_change; 
reg      [6:0] nick_count;
reg      [6:0] dime_count;

	
wire        start_deposit;
wire     [2:0] led;
wire        dec_nick;
wire        dec_dime;
wire [25:0] count;


//instantiate both dispense FSM and timer

dispense_system dut(clk, reset_n, user_balance,start_dispense, will_user_get_change, nick_count,
dime_count, start_deposit, led, dec_nick, dec_dime, count);




//clock
initial begin  
clk = 0;
forever #10 clk = ~clk;
end

initial begin 
//intialize 
reset_n = 0; //press reset
user_balance = 7'd55;
start_dispense = 0;
will_user_get_change = 1;
nick_count = 10;
dime_count = 10;

#20;
reset_n = 1; //release

#20;

// 80 cents
nick_count = 10;
dime_count = 10;
user_balance = 7'd80;
will_user_get_change = 1'b1;
start_dispense = 1;
#20;
start_dispense = 0;

#5000;
$stop;


end

endmodule