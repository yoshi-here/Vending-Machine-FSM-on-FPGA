////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: FSM_dispense_yoshita.v
// Author:   Yoshita Papasani
// Date:    4/24/26
// Revision: 1
//
// Description: This module is part of the dispense_system module. This section takes care of 
// taking in the user_balance and will_user_get_change from the FSM_deposit_yoshita and also the signal from the 
// timer counter to know when to turn on the LEDs to dispense product/money.
//
////////////////////////////////////////////////////////////////////////////////////////////////////





module FSM_dispense_yoshita(clock, reset_n, user_balance, start_dispense, timer_fin, will_user_get_change, nick_count, dime_count, start_deposit, start_timer,led, dec_nick, dec_dime );

input         clock;
input         reset_n;
input    [6:0]user_balance;
input         start_dispense;
input         timer_fin;
input         will_user_get_change; 
input   [6:0] nick_count;
input    [6:0] dime_count;
	
output        start_deposit;
output        start_timer;
output  [2:0] led;
output        dec_nick;
output        dec_dime;

reg [2:0] state;
reg [2:0] next_state;
reg [6:0] current_balance;



//userbalance inputed
//assign each parameter to decode what each state means 
 parameter OFF = 3'd1, START_DISPENSE = 3'd2, CHECK_BALANCE =3'd3, DIS_DIME = 3'd4, DIS_NICK= 3'd5; //coin representation

 //Sequential
 always@(posedge clock, negedge reset_n) begin
 
 if (!reset_n) begin 
     state <= OFF;
    current_balance <= 7'd0;
 end //end of reset_n active
 
 else begin
 state <= next_state;
 //subtract balance 
 
 //check balance
 if(state == OFF && start_dispense) begin  
    current_balance <= user_balance - 7'd60; 
 end
 //if dime is dispensed, calculate new balance 
 else if (state == DIS_DIME && timer_fin) begin
  current_balance <= current_balance - 7'd10;
 end
 //if nick is dispesed calculate new balance
 else if (state == DIS_NICK && timer_fin) begin 
  current_balance <= current_balance - 7'd5;
 
 end //end of if nick 
 
 end // end of reset_n = 1
 
 end // end of sequential
 
 
 
 //Excitation
 
 always@(*) begin 
 
 next_state = state; //default
 
 case(state)
 
      OFF: if(start_dispense) next_state = START_DISPENSE;
		
		START_DISPENSE: begin if (timer_fin) next_state = CHECK_BALANCE;
		
		                    else  next_state = START_DISPENSE;
		
		                  end
		
		CHECK_BALANCE: begin 
		
		//only give change if the exact change light indicator was off at the begining of the transaction
		if( current_balance > 0 && will_user_get_change) begin 
		   if(current_balance >= 7'd10 && dime_count > 0)
			  next_state = DIS_DIME;
			else if (current_balance >= 7'd5 && nick_count > 0)
			  next_state =  DIS_NICK; 
			else
			  next_state = OFF;
			  
		end
		
		 else begin 
		 next_state = OFF;
		 end
	   end
			
		DIS_DIME: begin if (timer_fin) next_state = CHECK_BALANCE;
		else next_state = DIS_DIME;
		
		end
		DIS_NICK: begin if (timer_fin) next_state = CHECK_BALANCE;
		else next_state = DIS_NICK;
		end 
		
		default: next_state = OFF;
		
		
		endcase
 end
		

 
 //Output

assign led[2] = (state == START_DISPENSE) ;
assign led[1] = (state == DIS_DIME) ;
assign led[0] =  (state == DIS_NICK);

assign start_timer = (state == START_DISPENSE || state == DIS_DIME || state == DIS_NICK);

assign dec_dime = (state == DIS_DIME && timer_fin);
assign dec_nick = (state == DIS_NICK && timer_fin);

assign start_deposit = ( state == CHECK_BALANCE && next_state == OFF);



endmodule