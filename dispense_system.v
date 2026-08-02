////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: dispense_system.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description:This creates a wrapper module for the dispense fsm and the timer to create a combined module.
//
////////////////////////////////////////////////////////////////////////////////////////////////////


module dispense_system( clock, reset_n, user_balance,
 start_dispense, will_user_get_change, nick_count,
 dime_count, start_deposit, led, dec_nick, dec_dime,count);
 
 
 input clock;
 input reset_n;
 input [6:0] user_balance;
 input start_dispense;
 input will_user_get_change;
 input [6:0] nick_count;
 input [6:0] dime_count;
 
 output start_deposit;
 output [2:0] led;
 output dec_nick;
 output dec_dime;
 
 wire timer_fin;
 wire start_timer;
 output [25:0] count;

 timer tim(clock ,reset_n, start_timer, count, timer_fin);
 
FSM_dispense_yoshita fsm(clock, reset_n, user_balance, start_dispense, timer_fin,
 will_user_get_change, nick_count, dime_count, start_deposit, start_timer,led, dec_nick, dec_dime );


 
 
 
 
 endmodule 