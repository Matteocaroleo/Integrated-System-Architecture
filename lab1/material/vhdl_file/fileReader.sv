`timescale 1ns/1ps
module file_reader();

	integer               data_file    ; // file handler
	integer               scan_file    ; // file handler
	logic   signed [21:0] captured_data;
	logic clk;
	`define NULL 0    
	

	always #5 clk = ~clk;

	initial begin
  		data_file = $fopen("../cFilterOut.txt", "r");
  		if (data_file == `NULL) begin
    			$display("data_file handle was NULL");
    			$finish;
  		end
	end

	always begin
	  scan_file = $fscanf(data_file, "%d\n", captured_data); 
	  if (!$feof(data_file)) begin
	    //use captured_data as you would any other wire or reg value;
		#1 $display ("integer value: %d, binary value: %b", captured_data, captured_data[14:0]);
	  end
	end
endmodule
