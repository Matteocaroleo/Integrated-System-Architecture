module tb_top();
	
	wire A_t [0:14];
	wire B_t [0:14];
	wire M_t [0:14];

	mul mul_dut (
		.A (A_t),
		.B (B_t),
		.M (M_t));

	initial begin
		A_t = h0;
		B_t = h0;
		#5 if (M_t == 0) begin
			$display ("test");
		end
		$finish
	end
endmodule
		
			
			
