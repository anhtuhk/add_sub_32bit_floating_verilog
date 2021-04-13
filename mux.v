module mux21_1bit(q,sel,a,b);
	input wire sel;
	input wire a,b;
	output wire q;
	assign q=sel?b:a;
endmodule

module mux21_8bit(q,sel,a,b);
	input wire sel;
	input wire [7:0]a,b;
	output wire [7:0]q;
	assign q=sel?b:a;
endmodule

module mux21_24bit(q,sel,a,b);
	input wire sel;
	input wire [23:0]a,b;
	output wire [23:0]q;
	assign q=sel?b:a;
endmodule

