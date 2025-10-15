//`timescale 1ns/1ps
module tb_fir_top();
		
	parameter integer N_bit = 15;	

	logic VOUT_tb ;
	logic signed [(N_bit-1):0] DOUT_tb;
	
	wire RST_n_tb; 
	wire CLK_tb;    
	wire END_SIM_tb;	
	wire [(N_bit-1):0] datamaker_dout ;
	wire datamaker_vout;
	wire [(N_bit-1):0] datamaker_B0;
	wire [(N_bit-1):0] datamaker_B1;
	wire [(N_bit-1):0] datamaker_B2;
	wire [(N_bit-1):0] datamaker_B3;
	wire [(N_bit-1):0] datamaker_B4;
	wire [(N_bit-1):0] datamaker_B5;
	wire [(N_bit-1):0] datamaker_B6;
	wire [(N_bit-1):0] datamaker_B7;
	wire [(N_bit-1):0] datamaker_B8;
	

	clk_gen clk_gen_tb (
		.END_SIM (END_SIM_tb),
		.CLK (CLK_tb),
		.RST_n (RST_n_tb)
	); 
	
	data_maker #(N_bit) data_maker_tb (
 		.CLK (CLK_tb),    	
 	       .RST_n (RST_n_tb),
 	       .VOUT (datamaker_vout),
 		.B0 (datamaker_B0),
 		.B1 (datamaker_B1),
 		.B2 (datamaker_B2),
 		.B3 (datamaker_B3),
 		.B4 (datamaker_B4),
 		.B5 (datamaker_B5),
 		.B6 (datamaker_B6),
 		.B7 (datamaker_B7),
 		.B8 (datamaker_B8),
		.DOUT (datamaker_dout),  
 	       .END_SIM (END_SIM_tb)
	);

	datapath firFilter_tb (
		.DIN(datamaker_dout),
		.VIN(datamaker_vout),
		.B0 (datamaker_B0),
		.B1 (datamaker_B1),
		.B2 (datamaker_B2),
		.B3 (datamaker_B3),
		.B4 (datamaker_B4),
		.B5 (datamaker_B5),
		.B6 (datamaker_B6),
		.B7 (datamaker_B7),
		.B8 (datamaker_B8),
		.VOUT(VOUT_tb),
		.DOUT(DOUT_tb),
		.clock(CLK_tb),
		.reset(RST_n_tb)
	);
		
	data_sink #(N_bit) datasink_tb (
		.CLK (CLK_tb),
		.RST_n (RST_n_tb),
		.VIN (VOUT_tb),
		.DIN (DOUT_tb)
	);		
	
	

	initial begin
		#50000
		$finish;
	end
endmodule
