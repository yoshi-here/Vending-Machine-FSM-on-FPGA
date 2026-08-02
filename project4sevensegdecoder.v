////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Filename: project3bsevensegdecoder.v
// Author:   Yoshita Papasani
// Date:      3/31/26  
// Revision:  3/31/26  
//
// Description: This is the model for an seven-segment decoder for hexadecimal digits. Review HW 2
//              for guidance on the DE1-SOC's seven segment displays.
//
//              This module and port declaration matches the one you used in HW 2 and HW 4. You
//              should be able to copy the code from one of those models into this file to use one
//              of the seven-segment decoders you have already written.
//
////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//  DO NOT MODIFY THE MODULE DECLARATION OR PORT DECLARATION WITHOUT PERMISSION! //
//  You MAY declare wires in the module and use them as needed.                  //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

module sevensegmentdecoder(hex_digit, hex_display);
   input  [3:0] hex_digit;
	output [6:0] hex_display;
	reg    [6:0] hex_display;

always@(hex_digit) begin
case(hex_digit)
         4'h0: hex_display= 7'b100_0000;
         4'h1: hex_display = 7'b111_1001;
         4'h2: hex_display = 7'b010_0100;
         4'h3: hex_display = 7'b011_0000;
         4'h4: hex_display = 7'b001_1001;
         4'h5: hex_display = 7'b001_0010;
         4'h6: hex_display = 7'b000_0010;
         4'h7: hex_display = 7'b111_1000;
         4'h8: hex_display = 7'b000_0000;
         4'h9: hex_display = 7'b001_0000;
         4'hA: hex_display = 7'b000_1000;
         4'hB: hex_display = 7'b000_0011;
         4'hC: hex_display = 7'b100_0110;
         4'hD: hex_display = 7'b010_0001;
         4'hE: hex_display = 7'b000_0110;
         4'hF: hex_display = 7'b000_1110;
         default: hex_display = 7'b111_1111;
	endcase
end
	
endmodule