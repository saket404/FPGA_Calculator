//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:10:52 04/19/2016 
// Design Name: 
// Module Name:    Calculator 
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
module Calculator (
clock,
push_1, push_2, push_3, push_4, push_5,
switch_1, switch_2, switch_3, switch_4, switch_5, switch_6, switch_7, switch_8,
led_1, led_2, led_3, led_4, led_5, led_6,  led_7, led_8,
digit, seg
);
//-------------Input Ports-----------------------------
input clock;
input push_1, push_2, push_3, push_4, push_5;
input switch_1, switch_2, switch_3, switch_4, switch_5, switch_6, switch_7, switch_8;
//-------------Output Ports----------------------------
output led_1, led_2, led_3, led_4, led_5, led_6, led_7, led_8;
output	[3:0] digit;
output  [6:0] seg; 
//-------------Output Ports Data Type------------------
wire [2:0] func;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] huns;
wire [3:0] thuns;
wire [3:0] selected;
wire [13:0] out;
wire [14:0] eight;  

count800 Cont(eight, clock);

Calculator_controller Calc(clock, push_1, push_2, push_3, push_4, push_5, switch_1, 
switch_2, switch_3, switch_4, switch_5, switch_6, switch_7, switch_8,
led_1, led_2, led_3, led_4, led_5, led_6, led_7, led_8, func, out);

bcd BCD(out, func, thuns, huns, tens, ones);

mux4to1 MUX(ones, tens, huns, thuns, eight[14:13], selected);

BCDto7Seg BCD27(seg, selected);

decoder Dec(digit, eight[14:13]);

endmodule