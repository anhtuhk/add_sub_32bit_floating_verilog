module top(A,B,S);
	input wire [31:0]A,B;
	output wire [31:0]S;
	wire [23:0]a,b,s,so,small_number,larger_number,shifted_small_number;
	wire [7:0]exp_a,exp_b,exp_s,exp_so,exp_difference;
	wire sign_a,sign_b,sign_s,sign_smaller_number,sign_larger_number;
	wire co_exp;
	assign sign_a=A[31];
	assign sign_b=B[31];
	assign exp_a=A[30:23];
	assign exp_b=B[30:23];
	assign a={1'b1,A[22:0]};
	assign b={1'b1,B[22:0]};
	small_alu sa0(exp_a,exp_b,exp_difference,co_exp);    //co_exp=1 expA>=expB ; co_exp=0 expA<expB
	mux21_8bit 	m0(exp_s,co_exp,exp_b,exp_a); //exp_s = exp cua so lon hon
	mux21_24bit m1(small_number,co_exp,a,b);
	mux21_24bit m2(larger_number,co_exp,b,a);
	mux21_1bit  m3(sign_smaller_number,co_exp,sign_a,sign_b);
	mux21_1bit  m4(sign_larger_number ,co_exp,sign_b,sign_a); 
	shift_right sr0(small_number,shifted_small_number,exp_difference);
	big_alu   	ba0(shifted_small_number,larger_number,sign_smaller_number,sign_larger_number,s,sign_s);
	normalize	n0(s,exp_s,so,exp_so);
	assign S={sign_s,exp_so,so[22:0]};
endmodule

