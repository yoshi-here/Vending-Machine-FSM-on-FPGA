////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename:    FSM_Deposit_yoshita.v
// Author:      Yoshita Papasani
// Date:        4/20/26
// Version:     4/20/26
// Description: The file is the FSM that handles the amount of money deposited into the vending machine. 
//
////////////////////////////////////////////////////////////////////////////////////////////////////

module FSM_Deposit_yoshita(clock, reset_n, enable, mode, coin_slot, start_deposit, nick_count, dime_count, user_balance, start_dispense, exact_change,will_user_get_change);
	input         clock;
	input         reset_n;
	input         enable;
	input         mode;
	input   [1:0] coin_slot;
	input         start_deposit;
	input   [6:0] nick_count;
	input   [6:0] dime_count;  
	
	output  [6:0] user_balance;
   output        start_dispense;	
	output        exact_change;
	
	

   wire         enough_change;
	reg    [6:0] state;
	reg    [6:0] next_state;
	output reg   will_user_get_change; //records if user will get money based on if the LED3 light being on 
	

	
  
	

	
 parameter N = 2'd1, D = 2'd2, Q =2'd3; //coin representation
 
  parameter S0 = 7'd0, S5= 7'd5, S10=7'd10, S15 = 7'd15, S20 = 7'd20, S25 = 7'd25, S30 = 7'd30, S35 = 7'd35, S40 = 7'd40, S45 = 7'd45,
   S50 = 7'd50, S55 = 7'd55, S60= 7'd60, S65 = 7'd65, S70 = 7'd70, S75= 7'd75, S80 = 7'd80;
	
	
// REGISTER BLOCK: This block represents SEQUENTIAL LOGIC so it uses non-blocking assignment. It
// is sensitized to appropriate edges of the clock input and the reset input.
	always @(posedge clock, negedge reset_n) begin
	// If reset_n is 0, there must have been a negative edge on the reset. The effect of the reset
	// occurs without a clock edge so the reset is ASYNCHRONOUS.	

		if(reset_n == 1'b0) begin
			   state <= S0;
				will_user_get_change <= 1'b0;
		end
	   else if (start_deposit) begin
			   state <= S0;
				will_user_get_change <= 1'b0;
		end
		else if (enable && mode == 0) begin
		     
		      state <= next_state;
				if (state == S0 && coin_slot != 2'b00) begin
				 will_user_get_change <= ~exact_change;
				 end
		end
		
		end
	
// EXCITATION LOGIC: This block represents COMBINATIONAL LOGIC so it uses blocking assignment. It
// is sensitized to changes in the FSM present state and the key input. Picture this block as the
// combinational logic that feeds the flip-flop inputs. It determines the next state based on the
// current state and the key value.
	
	// If reset is not 0 but this always block is executing anyway, there must have been a positive
	//	clock edge. On each positive clock edge where enable is asserted, update the counter state 
	// based on the counter state and the values of check, mode, direction, and value.
		
	always@(*) begin
	
	next_state = state;
	
	//only change states if enable, in usermode, dispense threshold is not met
if( (enable == 1'd1) && (mode == 0) && (state < S60) ) begin
//default

	case(state)
S0: begin 


if(coin_slot == Q ) next_state = S25;
else if (coin_slot == D) next_state = S10;
else if (coin_slot == N) next_state = S5;
else next_state = S0;
end//S0

S5: begin 
if (coin_slot == Q) next_state = S30;
else if (coin_slot == D) next_state = S15;
else if (coin_slot == N) next_state = S10;
else next_state = S5;
end//S5

S10: begin 
 if (coin_slot == Q) next_state = S35;
else if (coin_slot == D) next_state = S20;
else if (coin_slot == N) next_state = S15;
else next_state = S10;
end//S10

S15: begin 

 if (coin_slot == Q) next_state = S40;
else if (coin_slot == D) next_state = S25;
else if (coin_slot == N) next_state = S20;
else next_state = S15;
end//S15


S20: begin 
 if (coin_slot == Q) next_state = S45;
else if (coin_slot == D) next_state = S30;
else if (coin_slot == N) next_state = S25;
else next_state = S20;
end//S20




S25: begin 
 if (coin_slot == Q) next_state = S50;
else if (coin_slot == D) next_state = S35;
else if (coin_slot == N) next_state = S30;
else next_state = S25;
end//S25


S30: begin 
 if (coin_slot == Q) next_state = S55;
else if (coin_slot == D) next_state = S40;
else if (coin_slot == N) next_state = S35;
else next_state = S30;
end//S30

S35: begin 
 if (coin_slot == Q) next_state = S60;
else if (coin_slot == D) next_state = S45;
else if (coin_slot == N) next_state = S40;
else next_state = S35 ;
end//S35


S40: begin 
 if (coin_slot == Q) next_state = S65;
else if (coin_slot == D) next_state = S50;
else if (coin_slot == N) next_state = S45;
else next_state = S40 ;
end//S40

S45: begin 
 if (coin_slot == Q) next_state = S70;
else if (coin_slot == D) next_state = S55;
else if (coin_slot == N) next_state = S50;
else next_state = S45 ;
end//S45


S50: begin 
 if (coin_slot == Q) next_state = S75;
else if (coin_slot == D) next_state = S60;
else if (coin_slot == N) next_state = S55;
else next_state = S50 ;
end//S50


S55: begin 
 if (coin_slot == Q) next_state = S80;
else if (coin_slot == D) next_state = S65;
else if (coin_slot == N) next_state = S60;
else next_state = S55 ;
end//S55

S60: next_state = state;
S65: next_state = state;
S70: next_state = state;
S75: next_state = state;
S80: next_state = state;


default: next_state = state;
endcase
end //end of if 
else if ((enable == 1'd1) && (mode == 1) && (start_deposit == 1) ) begin
next_state = state;

end // end of else if

	end// end of excitation
	
	
	
	
	
	
	
	
	
// OUTPUT MACHINE: Since the output is always the same as the FSM state, assign the present state
// to the output. The output machine is combinational logic. A continuous assignment represents 
// combinational logic. In a more complex FSM, the output machine would have consisted of an always
// block. Since the output machine represents combinational logic, this always block would have used
// blocking assignments.

// You should not need to modify this continuous assignment. Changing counter_state in the state
// machine will change the output machine directly.

	assign user_balance = state;
	assign start_dispense = (state >= S60) && (mode == 0);
	

   assign enough_change = ( ( ( dime_count >= 7'd2) || ( dime_count >= 7'd1 && nick_count >= 7'd2 ) || (nick_count >= 7'd4) ) && ( nick_count >= 7'd1));
	
	assign exact_change = ~enough_change;
	   


		
	

endmodule
