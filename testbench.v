module testbench();
	reg [31:0]A,B;
	reg f;
	wire [31:0]S;
	integer i;
	top u1(f,A,B,S);
	initial begin
	   A<=32'b01000000110001111010111000010100;//6.24 
      B<=32'b11000010110100010011001100110011;//-104.6
		f=0;	
		#10
		f=1;
		#10
		$finish;
	end
	initial begin
		$vcdplusfile("waveform.vpd");
		$vcdpluson();
	end
endmodule
	
