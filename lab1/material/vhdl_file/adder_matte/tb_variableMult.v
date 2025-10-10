`timescale 1ns/1ps
module tb_top();
	
	//i1nt datawidth = 15;

	reg [14:0] A_t; //=14'h1;
	reg [14:0] B_t; //= 14'h1;
	wire [14:0] Y_t ;
	
	//ogic A_t [0:14]; //=14'h1;
	//logic B_t [0:14]; //= 14'h1;
	//logic Y_t [0:datawidth-1];

	variableMult MULT69(
		.A(A_t),
		.B(B_t),
		.Y(Y_t)
	);
	initial begin
		B_t = 15'b010000000000000;//15'h1;
		A_t = B_t;
		#2
		A_t = 'h1;
		B_t = 15'b010000000100000;//15'h1;

		#2; $display ("A=%0b, B=%0b, Y=%0b", A_t, B_t, Y_t);
		$finish;

	end
endmodule
