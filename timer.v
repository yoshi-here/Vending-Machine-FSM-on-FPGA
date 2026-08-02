////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: timer.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description:This module works with the dispense fsm module to know when to start the timer
//             for the one second led and when to stop the timer so dispense fsm knows when to stop led.
//
////////////////////////////////////////////////////////////////////////////////////////////////////
module timer(clock,reset_n, start_timer, count, timer_fin);
input       clock;
input       reset_n;
input       start_timer; //enable


output reg [25:0] count; //counter state
output  timer_fin; //timer finished pulse 

reg        timer_running;



always@(posedge clock or negedge reset_n) begin

   if(!reset_n) begin
	//if reset is pressed, turn off the timer
	    count <= 26'd0;
	    timer_running <= 1'd0;
	 
		 end //end reset_n
		 
	//if the start_timer signal is given and the timer already did not start running	 
		 else if (start_timer && !timer_running) begin 
		 timer_running <= 1'b1;
		 count <=  26'd0;
	
		 
		 end // end start the timer sequence
		 else if (timer_running) begin 
		   if(count == 26'd49999999) begin //49999999
			//roll over 
		      count <= 26'd0;
			   timer_running <= 1'b0;
			 	
				end //end of count max
		    else begin
			   count <= count + 1'b1;
			
				end //end of incrementing timer
				
		  end //end of timer_running
		  
		

end//end total block

//output machine
assign timer_fin = (count == 26'd49999999) && timer_running;
endmodule