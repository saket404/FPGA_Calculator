//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:1:52 04/19/2016 
// Design Name: 
// Module Name:    Calculator_controller 
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
module Calculator_controller ( 
clock,
push_1, push_2, push_3, push_4, push_5,
switch_1, switch_2, switch_3, switch_4, switch_5, switch_6, switch_7, switch_8,
led_1, led_2, led_3, led_4, led_5, led_6, led_7, led_8,
func, out
);
//-------------Input Ports-----------------------------
input clock, push_1, push_2, push_3, push_4, push_5;
input switch_1, switch_2, switch_3, switch_4, switch_5, switch_6, switch_7, switch_8;
//-------------Output Ports----------------------------
output reg led_1, led_2, led_3, led_4, led_5, led_6, led_7, led_8;
output reg [13:0] out;
output reg [2:0] func;
//-------------Output Ports Data Type------------------
reg op1_reg;
reg op2_reg;
reg res_reg;
reg [1:0] op_func;
reg [2:0] func_reg;
reg [2:0] shifter;
reg [3:0] op1_most;
reg [3:0] op1_least;
reg [3:0] op2_most;
reg [3:0] op2_least;
reg [3:0] operand; 
reg [2:0] num_switch;
reg [13:0] out_reg;
reg [6:0] divisor;
//-------------Internal Constants--------------------------
parameter SIZE 		= 3;
parameter Idle		= 3'b000;
parameter LSD_OP1 	= 3'b001;
parameter MSD_OP1 	= 3'b010;
parameter operation = 3'b011;
parameter LSD_OP2 	= 3'b100;
parameter MSD_OP2 	= 3'b101;
parameter equal 	= 3'b110;
parameter error 	= 3'b111;
//-------------Internal Variables---------------------------
reg  [SIZE-1:0] state        ;// FSM
//----------Code startes Here------------------------
always @ (push_1 or push_2 or push_3 or push_4 or push_5 or switch_2 or switch_3 or switch_4 or switch_5 or switch_6 or switch_7 or switch_8) 
begin : FSM_COMBO
  case(state)
	Idle : begin  
		if ((~push_1 || ~push_2 || ~push_3 || ~push_4 || ~push_5) && switch_2)
			state <= LSD_OP1;
		else 
			state <= Idle;
	end
	
	LSD_OP1 : begin
		if (~switch_8)
			state <= Idle;
		else if (~switch_3 || ~switch_4 || ~switch_5 || ~switch_6)			
			state <= operation;
		else if (~switch_7)
			state <= equal;	
		else if ((~push_1 || ~push_2 || ~push_3 || ~push_4 || ~push_5)&& ~switch_2)
			state <= MSD_OP1; 	
		else 
			state <= LSD_OP1;
	end
	
	MSD_OP1 : begin
		if (~switch_8)
			state <= Idle;
		else if (~switch_3 || ~switch_4 || ~switch_5 || ~switch_6) 
			state <= operation;
		else if (~switch_7) 
			state <= equal;
		else
			state <= MSD_OP1;
	end
	
	operation : begin
		if (~switch_8)
			state <= Idle;
		else if (~switch_7)
			state <= error;	
		else if ((~push_1 || ~push_2 || ~push_3 || ~push_4 || ~push_5) && switch_2)
			state <= LSD_OP2;
		else 
			state <= operation;
	end
	
	LSD_OP2 : begin
		if (~switch_8)
			state <= Idle;
		else if (~switch_7)
			state <= equal;	
		else if ((~push_1 || ~push_2 || ~push_3 || ~push_4 || ~push_5) && ~switch_2)
			state <= MSD_OP2; 	
		else 
			state <= LSD_OP2;
	end
	
	MSD_OP2 : begin
		if (~switch_8)
			state <= Idle;
		else if (~switch_7)
			state <= equal;			
		else 
			state <= MSD_OP2;
	end
	
	equal : begin
		if (~switch_8)
			state <= Idle;
		else if ((~push_1 || ~push_2 || ~push_3 || ~push_4 || ~push_5) && switch_2) 
			state <= LSD_OP1; 
		else if (~switch_3 || ~switch_4 || ~switch_5 || ~switch_6)
			state <= operation;
		else
			state <= equal;
	end
	
	error : begin
		if (~switch_8)
			state <= Idle;
		else
			state <= error;
	end
			
	default : state <= Idle;
  endcase
end
//----------Output Logic-----------------------------
always @ (posedge clock)
begin : OUTPUT_LOGIC
	
	if (~switch_8) begin
			out = 0;
			op1_most = 0;
			op1_least = 0;
			op2_most = 0;
			op2_least = 0;
			operand = 0; 
			num_switch = 0;
			func = 0;
			func_reg = 0;
			op1_reg = 0;
			op2_reg = 0;
			op_func = 0;
			res_reg = 0;
			divisor = 0;
			shifter = 0;
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
	end
	
	else begin
	
	if(switch_3 && switch_4 && switch_5 && switch_6) begin
		if(switch_1)		//0-4 and 5-9 control
			num_switch = 3'b000;
		else if(~switch_1)
			num_switch = 3'b101;
	end
	
	if	(~push_1)
		operand = 4'b000 + num_switch;	
	else if(~push_2) 		
		operand = 4'b001 + num_switch;
	else if(~push_3)		
		operand = 4'b010 + num_switch;
	else if(~push_4)		
		operand = 4'b011 + num_switch;
	else if(~push_5)
		operand = 4'b100 + num_switch;
	
	case(state)
		Idle : begin
			led_1 = 1;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			out = 0;
			op1_most = 0;
			op1_least = 0;
			op2_most = 0;
			op2_least = 0;
			operand = 0; 
			num_switch = 0;
			func = 0;
			func_reg =0;
			op_func = 0;
			op1_reg = 0;
			op2_reg = 0;
			res_reg = 0;
			divisor = 0;
			shifter = 0;
		end
		
		LSD_OP1 : begin
			led_1 = 0;
			led_2 = 1;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			if (op1_reg == 0) begin
				op1_most = 0;
				op1_least = operand;
				op1_reg = 1;
			end
			out = op1_most * 10 + op1_least;
			res_reg = 0;
			func = 3'b000;
			op_func = 2'b01;
		end
		
		MSD_OP1 : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 1;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			if (op1_reg == 1) begin
				op1_most = op1_least;
				op1_least = operand;
				op1_reg = 0;
			end
			out = op1_most * 10 + op1_least;
			func = 3'b000;			
			
		end
		
		operation : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 1;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			res_reg = 0;
			if (~switch_3) begin
				func = 3'b001; 
				func_reg = 3'b100; 
			end
			else if (~switch_4) begin
				func = 3'b010;
				func_reg = 3'b101;
			end
			else if (~switch_5) begin
				func = 3'b011;
				func_reg = 3'b110;
			end
			else if (~switch_6) begin
				func = 3'b100;
				func_reg = 3'b111;
			end
		end
		
		LSD_OP2 : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 1;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			if (op2_reg == 0) begin
				op2_most = 0;
				op2_least = operand;
				op2_reg = 1;
			end
			out = op2_most * 10 + op2_least;
			divisor = op2_most * 10 + op2_least;
			func = 3'b000;
		end
		
		MSD_OP2 : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 1;
			led_7 = 0;
			led_8 = 0;
			if (op2_reg == 1) begin
				op2_most = op2_least;
				op2_least = operand;
				op2_reg = 0;
			end
			out = op2_most * 10 + op2_least;
			divisor = op2_most * 10 + op2_least;
			func = 3'b000;
		end
		
		
		equal : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 1;
			led_8 = 0;
			op1_reg = 0;
			op2_reg = 0;
			if(func_reg == 3'b111) begin
				if (divisor == 7'b0000010)
					shifter = 1;
				else if (divisor == 7'b0000100)
					shifter = 2;
				else if (divisor == 7'b0001000)
					shifter = 3;
				else if (divisor == 7'b0010000)
					shifter = 4;
				else if (divisor == 7'b0100000)
					shifter = 5;
				else if (divisor == 7'b1000000)
					shifter = 6;
				else
					shifter = 0;
			end
			if (res_reg == 0) begin
				res_reg = 1;
				if (op_func == 2'b01) begin
					if (func_reg == 3'b100)
						out = (op1_most * 10 + op1_least) + (op2_most * 10 + op2_least);
					else if (func_reg == 3'b101)
						out = (op1_most * 10 + op1_least) - (op2_most * 10 + op2_least);
					else if (func_reg == 3'b110)
						out = (op1_most * 10 + op1_least) * (op2_most * 10 + op2_least);
					else if (func_reg == 3'b111)
						out = (op1_most * 10 + op1_least) >> shifter;
					out_reg = out;
				end 
				else if (op_func == 2'b10) begin
					if (func_reg == 3'b100)
						out = out_reg + (op2_most * 10 + op2_least);
					else if (func_reg == 3'b101)
						out = out_reg - (op2_most * 10 + op2_least);
					else if (func_reg == 3'b110)
						out = out_reg * (op2_most * 10 + op2_least);
					else if (func_reg == 3'b111)
						out = out_reg >> shifter;
			      out_reg = out;
				end
			end
			op_func = 2'b10;
			func = 3'b000;
			out_reg = out;
		end

		error : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 1;
			func = 3'b101; 
		end	
		
		default : begin
			led_1 = 0;
			led_2 = 0;
			led_3 = 0;
			led_4 = 0;
			led_5 = 0;
			led_6 = 0;
			led_7 = 0;
			led_8 = 0;
			out = 0;
			op1_most = 0;
			op1_least = 0;
			op2_most = 0;
			op2_least = 0;
			operand = 0; 
			num_switch = 0;
			func = 0;
			func_reg =0;
			op_func = 0;
			res_reg = 0;
			op1_reg = 0;
			op2_reg = 0;
			divisor = 0;
			shifter = 0;
		end
			
	endcase	
  end
end // End Of Block OUTPUT_LOGIC

endmodule // End of Module arbiter