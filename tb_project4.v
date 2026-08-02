////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_project4.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description: This file is the overall test bench for the top level module of the vending machine.
//
////////////////////////////////////////////////////////////////////////////////////////////////////





`timescale 1ns/1ns
module tb_project4();




reg        clock;		
reg  [1:0] key;				
reg  [9:0] sw;				
									
wire [6:0] hex5, hex4;	
wire [6:0] hex3, hex2;	
wire [6:0] hex1, hex0;	
wire  [9:0] led;			
										
project4 dut(clock, key, sw, hex5, hex4, hex3, hex2, hex1, hex0, led);

initial begin 
    clock = 0;
	 forever #10 clock = ~clock;

end


initial begin 
//initialize

key = 2'b11;
sw = 10'd0;

#40;
//press reset
key[1] = 1'b0;
#40;
key[1] = 1'b1;
#40;


//test 1: user mode with no change
sw[9] = 1'b0;
sw [1:0] = 2'b11;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#100;

#5000;


//Test 2: Switch to maintance mode and add two nickles and 5 dimes
sw[9] = 1'b1;
sw [1:0] = 2'b01;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

sw [1:0]= 2'b10;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#1500;

// all of the lights should be off

//Test 3: Switch back to user mode and expect change of 15 cents 
sw[9] = 1'b0;
sw [1:0] = 2'b11;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#40;

//load coin
key [0] = 1'b0;
#40;
key [0] = 1'b1;
#2000;

//Result: led 2 on for 1 sec, then  led 1 , then led 0
$stop;

end



endmodule 