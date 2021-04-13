module shift_right_1bit(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{1'b0,unshift[23:1]}:unshift;
endmodule

module shift_right_2bit(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{2'b00,unshift[23:2]}:unshift;
endmodule

module shift_right_4bit(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{4'b0000,unshift[23:4]}:unshift;
endmodule

module shift_right_8bit(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{8'b00000000,unshift[23:8]}:unshift;
endmodule

module shift_right_16bit(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{16'h0,unshift[23:16]}:unshift;
endmodule

module shift_right_else(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire sel;
	output wire [23:0]shifted;
	assign shifted= (sel)?{24'd0}:unshift;
endmodule

module shift_right(unshift,shifted,sel);
	input wire [23:0]unshift;
	input wire [7:0]sel;
	output wire [23:0]shifted;
	wire [23:0] temp7,temp6,temp5,temp16,temp8,temp4,temp2;
	shift_right_else  sr7 (unshift,temp7  ,sel[7]);
	shift_right_else  sr6 (temp7  ,temp6  ,sel[6]);
	shift_right_else  sr5 (temp6  ,temp5  ,sel[5]);
	shift_right_16bit sr16(temp5  ,temp16 ,sel[4]);
	shift_right_8bit  sr8 (temp16 ,temp8  ,sel[3]);
	shift_right_4bit  sr4 (temp8  ,temp4  ,sel[2]);
	shift_right_2bit  sr2 (temp4  ,temp2  ,sel[1]);
	shift_right_1bit  sr1 (temp2  ,shifted,sel[0]);
endmodule



