`timescale 1ns/1ps
`define NULL 0    
module tb_fir_top();
		
	parameter integer N_bit = 15;	

	integer               	data_file    ; // file handler
	integer			output_file  ; // file handler 
	integer 	        scan_file    ; // file handler
	logic signed [(N_bit-1):0] captured_data;
	


	logic CLK_tb;    
	logic RST_n_tb; 
	logic VOUT_tb ;
	logic signed [(N_bit-1):0] DOUT_tb;
	logic END_SIM_tb;
		
	wire [N_bit-1:0] datamaker_dout ;
	wire datamaker_vout;

	// Clock Generator
	always #5 CLK_tb = ~CLK_tb;

	data_maker #(N_bit) data_maker_tb (
 		.CLK (CLK_tb),    	
 	       .RST_n (RST_n_tb),
 	       .VOUT (datamaker_vout),
 	       .DOUT (datamaker_dout),  
 	       .END_SIM (END_SIM_tb)
	);

	datapath firFilter_tb (
		.DIN(datamaker_dout),
		.VIN(datamaker_vout),
		.VOUT(VOUT_tb),
		.DOUT(DOUT_tb),
		.clock(CLK_tb),
		.reset(RST_n_tb)
	);
		
		
		

	initial begin
		RST_n_tb = 0;
		CLK_tb = 1;

		#10 RST_n_tb = 1;	
		
// file handling stuff should be in a task...
		data_file = $fopen ("../cFilterOut.txt", "r"); 	// input data file
		output_file = $fopen ("filterOut.txt","w");	// output data file
		if ((data_file == `NULL) || (data_file == `NULL)) begin
    			$display("data_file handle was NULL");
    			$finish;
  		end	
		
		for (int i = 0; (i < 1000) && (!$feof(data_file)); i++) begin
			#10
			$display ("datamaker_vout value: %b", datamaker_vout); 
			$display ("DOUT_tb value: %b, %d, %f", DOUT_tb, DOUT_tb, DOUT_tb/$pow(2,N_bit)); 
			$display ("VOUT_tb value: %b", VOUT_tb);
			
			// read new line ONLY IF valid
			if (datamaker_vout == 1) begin
				scan_file = $fscanf (data_file, "%d", captured_data);
				$fdisplay (output_file, "%d", DOUT_tb);
			end
			if (DOUT_tb != captured_data) begin
				$display ("ERROR: DOUT_tb = %d, captured_data = %d\n", DOUT_tb, captured_data);
  			end
			else begin
				$write("\n");
			end
		end
		$finish;
	end
endmodule
