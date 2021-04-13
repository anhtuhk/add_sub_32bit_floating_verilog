module fulladder(a,b,ci,s,co);
	input wire a,b,ci;
	output wire s,co;
	assign s=(a^b)^ci;
	assign co=(a&b)|(a&ci)|(b&ci);
endmodule

module alu_1bit(k,a,b,ci,s,co);
	input wire k,a,b,ci;
	output wire s,co;
	wire i;
	assign i=b^k;
	fulladder fa0(a,i,ci,s,co);
endmodule

module alu_8bit(k,a,b,ci,s,co);
	input wire k,ci;
	input wire [7:0]a,b;
	output wire [7:0]s;
	output wire co;
	wire [6:0]c;
	alu_1bit a0(k,a[0],b[0],ci,s[0],c[0]);
	alu_1bit a1(k,a[1],b[1],c[0],s[1],c[1]);
	alu_1bit a2(k,a[2],b[2],c[1],s[2],c[2]);
	alu_1bit a3(k,a[3],b[3],c[2],s[3],c[3]);
	alu_1bit a4(k,a[4],b[4],c[3],s[4],c[4]);
	alu_1bit a5(k,a[5],b[5],c[4],s[5],c[5]);
	alu_1bit a6(k,a[6],b[6],c[5],s[6],c[6]);
	alu_1bit a7(k,a[7],b[7],c[6],s[7],co);
endmodule

module alu_24bit(k,a,b,ci,s,co);
	input wire k,ci;
	input wire [23:0]a,b;
	output wire [23:0]s;
	output wire co;
	wire [1:0]c;
	alu_8bit a8_0(k,a[7:0],b[7:0],ci,s[7:0],c[0]);
	alu_8bit a8_1(k,a[15:8],b[15:8],c[0],s[15:8],c[1]);
	alu_8bit a8_2(k,a[23:16],b[23:16],c[1],s[23:16],co);
endmodule

module alu_24bit_k(k,a,b,s,co,h);
	input wire k;
	input wire [23:0]a,b;
	output wire [23:0]s;
	output wire co,h;
	wire [23:0]s0,s1,s2,s3;
	wire c0,c1,c3;
	alu_24bit a24_0(1'b0,a,b,1'b0,s0,c0);
	alu_24bit a24_1(1'b1,a,b,1'b1,s1,c1);
	assign s2=(~s1);
	alu_24bit a24_2(1'b0,s2,24'd1,1'b0,s3,c3);
	assign s	= 	(k==0)? s0 :(c1==1)? s1 :s3;
	assign co=  (k==0)? c0 :1'b0;
	assign h	=  (k==0)? 1'b1 :c1;
endmodule

module small_alu(a,b,s,co);
	input wire [7:0]a,b;
	output wire [7:0]s;
	output wire co;
	wire [7:0]s0,s1,s2;
	wire c1;
	alu_8bit s_a0(1'b1,a,b,1'b1,s0,co);
	assign s1=(~s0);
	alu_8bit s_a1(1'b0,s1,8'd1,1'b0,s2,c1);
	assign s= (co==1)? s0 :s2;
endmodule

module big_alu(a,b,sign_a,sign_b,s,sign_s,co);
	input wire [23:0]a,b;
	input wire sign_a,sign_b;
	output wire [23:0]s;
	output wire sign_s;
	output wire co;
	wire [23:0]s0,s1;
	wire k,h;
	wire sign_temp;
	assign k= sign_a ^ sign_b;
	alu_24bit_k a24k_0(k,a,b,s0,co,h);
	assign s			= (co==1)? {1'b1,s0[23:1]} : s0;
	assign sign_temp	= (sign_a & sign_b) | (sign_a & (~sign_b) );
	assign sign_s		= h? sign_temp : ~(sign_temp);
endmodule
	
