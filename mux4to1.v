`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:47 04/19/2016 
// Design Name: 
// Module Name:    mux4to1 
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
module mux4to1(
    input [3:0] digit1,digit2,digit3,digit4,
    input [1:0] in,
    output reg [3:0] out
    );
	always @ (digit1 or digit2 or digit3 or digit4 or  in)
	begin
		case(in)
			2'b00: out = digit1;
			2'b01: out = digit2;
			2'b10: out = digit3;
			2'b11: out = digit4;
		endcase
	end
endmodule
