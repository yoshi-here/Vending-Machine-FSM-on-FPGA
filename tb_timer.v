////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: tb_timer.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description:This tests if the one second timer works properly by see when it sets timer_fin high.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns
module tb_timer();

reg       clock;
reg       reset_n;
reg       start_timer; //enable


wire [25:0] count; //counter state
wire  timer_fin; //timer finished pulse 



					
 timer dut(clock,reset_n, start_timer, count, timer_fin);

initial begin 
    clock = 0;
	 forever #10 clock = ~clock;

end


initial begin 
//initialize
reset_n = 0;
start_timer = 0;
#40;
reset_n = 1;
#40;


//start timer 
start_timer = 1;
#20;
start_timer = 0;

#1100000000;

$stop;


end



endmodule 