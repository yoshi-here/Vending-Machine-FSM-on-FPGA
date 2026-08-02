

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: project4.v
// Author:   Yoshita Papasani
// Date:     4/24/26
// Revision: 0
//
// Description: This is the top-level module for ECE 3544 Project 4. It puts together the whole system 
//               to create a working vending machine that fits the specs of the project.
////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------------------
// Do NOT modify the module declaration.
//--------------------------------------

module project4(CLOCK_50, KEY, SW, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LED);

//---------------------------------------
// Do NOT modify these port declarations.
//---------------------------------------

	input        CLOCK_50;		// You must use this as the clock for all of your sequential hardware.
	input  [1:0] KEY;				// KEY[1] is the system reset. KEY[0] is the enable.
	input  [9:0] SW;				// SW[2] controls the mode. SW[1:0] represents a coin input.
										// The other switches are avaialble for debugging.
	output [6:0] HEX5, HEX4;	// HEX5 and HEX4 display the number of quarters in the machine.
	output [6:0] HEX3, HEX2;	// HEX3 and HEX2 display the number of dimes in the machine.
	output [6:0] HEX1, HEX0;	// HEX1 and HEX0 display the number of nickels in the machine.
	output [9:0] LED;				// LED[3] lights when the user must use exact change.
										// LED[2] lights for one second when the product is dispensed.
										// LED[1] lights for one second for each dime dispensed in change.
										// LED[0] lights for one second for each nickel dispensed in change.
										// The other LEDs are available for debugging.
	
// Add your reg/wire/parameter declarations here.


wire start_deposit, start_dispense, exact_change, will_user_get_change;
wire enable; 
wire [6:0] nick_count, dime_count, quat_count, user_balance;
wire [2:0]led;
wire dispense_nick, dispense_dime;
wire [25:0] timer_count;



//-----------------
// Module instances
//-----------------
keypress en(CLOCK_50, KEY[1], KEY[0], enable);

coin_counter step0(CLOCK_50, KEY[1], enable, SW[2], SW[1:0], dispense_nick,dispense_dime, nick_count, dime_count, quat_count);
FSM_Deposit_yoshita step1(CLOCK_50, KEY[1], enable, SW[2], SW[1:0], start_deposit, nick_count, dime_count, user_balance, start_dispense, exact_change, will_user_get_change);

//hexdisplays 
sevensegmentdecoder hex5({1'b0,quat_count[6:4]},HEX5 );
sevensegmentdecoder hex4(quat_count[3:0],HEX4);

sevensegmentdecoder hex3({1'b0, dime_count[6:4]},HEX3);
sevensegmentdecoder hex2(dime_count[3:0],HEX2);

sevensegmentdecoder hex1({1'b0, nick_count[6:4]},HEX1);
sevensegmentdecoder hex0(nick_count[3:0],HEX0);
  
//Step: Product dispense/ change
dispense_system step2( CLOCK_50, KEY[1], user_balance,
 start_dispense, will_user_get_change, nick_count,
 dime_count, start_deposit,led, dispense_nick, dispense_dime,timer_count);
  
  

// Add your module instances here. You may also add continuous assignments as appropriate.
assign LED[3] = exact_change; //exact change indicatior
assign LED[2] = led[2]; //product dispense //2 Q, 4 D
assign LED[1] = led[1]; //dime dispense
assign LED[0] = led[0]; //nickel dispense

//LEDs use for debugging
//assign LED[9] = (user_balance >= 7'd60); //2 Q, 4 D
//assign LED[8] = start_dispense;   //2 Q, 4 D
//assign LED[7] = will_user_get_change;
//assign LED[6] = start_deposit;
//assign LED[5] = dispense_nick;
//assign LED[4] = dispense_dime;


endmodule
