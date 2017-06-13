//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:52 04/19/2016 
// Design Name: 
// Module Name:    bcd 
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
module bcd(number, func, thuns, huns, tens, ones);
// I/O Signal Definitions
input  [13:0] number;
input  [2:0] func;
output reg [3:0] thuns;
output reg [3:0] huns;
output reg [3:0] tens;
output reg [3:0] ones;
   
// Internal variable for storing bits
reg [29:0] shift;
integer i;
   
always @(number, func)
begin
	    // Clear previous number and store new number in shift register
      shift[29:14] = 0;
      shift[13:0] = number;
	if (func == 3'b000) begin
      // Loop eight times
      for (i=0; i<14; i=i+1) begin
         if (shift[17:14] >= 5)
            shift[17:14] = shift[17:14] + 3;
            
         if (shift[21:18] >= 5)
            shift[21:18] = shift[21:18] + 3;
            
         if (shift[25:22] >= 5)
            shift[25:22] = shift[25:22] + 3;
			
         if (shift[29:26] >= 5)
            shift[29:26] = shift[29:26] + 3;
		 
         // Shift entire register left once
         shift = shift << 1;
		end	
   end
	else if (func == 3'b001) begin
		shift[29:26] = 4'h0;
		shift[25:22]  = 4'h0;
		shift[21:18]  = 4'h0;
		shift[17:14] = 4'hA; 
		end
	 else if (func == 3'b010) begin		
		shift[29:26] = 4'h0;
		shift[25:22]  = 4'h0;
		shift[21:18]  = 4'h0;
		shift[17:14]  = 4'hB;
		end
	else if (func == 3'b011) begin
		shift[29:26] = 4'h0;
		shift[25:22]  = 4'h0;
		shift[21:18]  = 4'h0;
		shift[17:14] = 4'hC;
		end
	else if (func == 3'b100) begin
		shift[29:26] = 4'h0;
		shift[25:22]  = 4'h0;
		shift[21:18]  = 4'h0;
		shift[17:14]  = 4'hD;
		end
	else if (func == 3'b101) begin
		shift[29:26] = 4'h0;
		shift[25:22]  = 4'hE;
		shift[21:18]  = 4'hF;
		shift[17:14]  = 4'hF;
		end
     // Push decimal numbers to output
	 thuns = shift[29:26];
     huns = shift[25:22];
     tens = shift[21:18];
     ones = shift[17:14];

	end
endmodule