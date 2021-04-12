module position(s,p);
	input  wire [23:0]s;
	output wire [4 :0]p;
	assign p= s[23]? 5'd0 :s[22]? 5'd1:  s[21]? 5'd2 :s[20]? 5'd3: s[19]? 5'd4 :s[18]? 5'd5: s[17]? 5'd6 :s[16]? 5'd7: s[15]? 5'd8 :s[14]? 5'd9: s[13]? 5'd10 :s[12]? 5'd11: s[11]? 5'd12 :s[10]? 5'd13: s[9]? 5'd14 :s[8]? 5'd15: s[7]? 5'd16 :s[6]? 5'd17: s[5]? 5'd18 :s[4]? 5'd19 :s[3]? 5'd20 : s[2]? 5'd21 :s[1]? 5'd22: s[0]? 5'd23 :5'd24;
endmodule

module normalize(s,exp_s,so,exp_so);
	input wire [23:0]  s;
	input wire [7:0]   exp_s;
	output wire [23:0] so;
	output wire [7:0]	 exp_so;
	wire [4:0]p,p_temp;
	wire co;
	position p0(s,p);
	shift_left sl_0(s,so,{3'b000,p});
	assign p_temp= (p==24)? 5'd0 :p;
	alu_8bit a8_n0(1'b0,exp_s,{3'b000,p_temp},1'b0,exp_so,co);
endmodule
