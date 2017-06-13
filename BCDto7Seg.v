`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:38 04/19/2016 
// Design Name: 
// Module Name:    BCDto7Seg 
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
module BCDto7Seg(
    output reg [6:0] out,
	input [3:0] count
    );
	always @ (count)
	begin
		case(count)
			//Numbers
			4'h0: out = ~7'b1000000;
			4'h1: out = ~7'b1111001;
			4'h2: out = ~7'b0100100;
			4'h3: out = ~7'b0110000;
			4'h4: out = ~7'b0011001;
			4'h5: out = ~7'b0010010;
			4'h6: out = ~7'b0000010;
			4'h7: out = ~7'b1111000;
			4'h8: out = ~7'b0000000;
			4'h9: out = ~7'b0010000;
			//Letters
			4'hA: out = ~7'b0001000;	//A
			4'hB: out = ~7'b0000011;	//b
			4'hC: out = ~7'b1000111;	//L
			4'hD: out = ~7'b0100001;	//d
			4'hE: out = ~7'b0000110;	//E
			4'hF: out = ~7'b0101111;	//r
			default: out = 7'bx;
		endcase
	end
endmodule
