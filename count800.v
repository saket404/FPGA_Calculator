`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:52 04/19/2016 
// Design Name: 
// Module Name:    count800 
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
module count800(count,clk);
	input clk;
	output reg [14:0] count=0;
	always @ (posedge clk)
		if (count == 15'd31250)
			count <= 15'b0;
		else
			count <= count + 15'd1;

endmodule
