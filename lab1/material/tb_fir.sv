//`timescale 1ns

module tb_fir ();

   logic CLK_i;
   logic RST_n_i;
   logic [15:0] DIN_i;
   logic VIN_i;
   logic [15:0] H0_i;
   logic [15:0] H1_i;
   logic [15:0] H2_i;
   logic [15:0] H3_i;
   logic [15:0] DOUT_i;
   logic VOUT_i;
   logic END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker SM(.CLK(CLK_i),
	         .RST_n(RST_n_i),
		 .VOUT(VIN_i),
		 .DOUT(DIN_i),
		 .H0(H0_i),
		 .H1(H1_i),
		 .H2(H2_i),
		 .H3(H3_i),
		 .END_SIM(END_SIM_i));

   myfir UUT(.CLK(CLK_i),
	     .RST_n(RST_n_i),
	     .DIN(DIN_i),
             .VIN(VIN_i),
	     .H0(H0_i),
	     .H1(H1_i),
	     .H2(H2_i),
	     .H3(H3_i),
             .DOUT(DOUT_i),
             .VOUT(VOUT_i));

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.VIN(VOUT_i),
		.DIN(DOUT_i));   

endmodule

		   