`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:14 04/19/2016 
// Design Name: 
// Module Name:    decoder 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module decoder(
    output reg [3:0] digit,
	 input [1:0] in
    );
	always @ (digit or in)
	begin
		case(in)
			2'b00: digit = 4'b1110;
			2'b01: digit = 4'b1101;
			2'b10: digit = 4'b1011;
			2'b11: digit = 4'b0111;
		endcase
	end
endmodule
