module Conv #(
	parameter int KERNEL_DIM = 2,
	parameter int KERNEL_CH  = 3,
	parameter int IMG_DIM	 = 4,
	parameter int IMG_CH		 = 3,
	parameter int OUT_DIM    = 2,
	parameter int INPUT_PREC = 8,
	parameter int OUTPUT_PREC= INPUT_PREC * 2,
	
   parameter BUFFER_SIZE = IMG_DIM * IMG_CH * KERNEL_DIM,
   parameter KERNEL_SIZE = KERNEL_DIM * KERNEL_DIM * KERNEL_CH,
	parameter IMG_SIZE    = IMG_DIM * IMG_DIM * IMG_CH

)(
    input clk, rst,
    input logic [INPUT_PREC - 1:0] in_img_stream,
	 input logic in_valid,
    input logic [INPUT_PREC - 1:0] Kernal_weights [0:KERNEL_DIM-1][0:KERNEL_DIM-1][0:KERNEL_CH-1],
    output logic [OUTPUT_PREC - 1:0] out_img_stream,
	 output logic out_valid
);

	 logic [INPUT_PREC - 1:0] in_read_addr [0:KERNEL_SIZE-1];
	 logic [INPUT_PREC - 1:0] current_conv_addr [0:KERNEL_SIZE-1];
	 logic [INPUT_PREC - 1:0] current_conv [0:KERNEL_SIZE-1];
	 logic [INPUT_PREC - 1:0] flattened_weights [0:KERNEL_SIZE-1];
	 reg [INPUT_PREC - 1:0] in_write_addr;
	 reg [INPUT_PREC - 1:0] current_pixel;
	 reg [INPUT_PREC - 1:0] last_result;
	 reg [INPUT_PREC - 1:0] save_pixel;
	 
	 reg set;
	 reg last;

	 integer index;
	 integer group;

	 
	 Counter #(
		  .COUNTER_SIZE(8)
	 ) pixel_count (
	 	 .clk(clk),
		 .rst(rst),
		 .en(in_valid),
		 .target(IMG_SIZE),
		 .count(current_pixel)
	 );
	 
	 MemoryUnit #(.MEMORY_SIZE(BUFFER_SIZE), .READ_ADDR_LEN(KERNEL_SIZE), .INPUT_PREC(INPUT_PREC)
	 ) internal_buffer(
		  .clk(clk),
		  .rst(rst),
		  .en(in_valid),
		  .in_addr(in_write_addr),
		  .in_data(in_img_stream),
		  .read_addr(current_conv_addr),
		  .read_data(current_conv)	  
	 );
	 
	 Counter #(
			.COUNTER_SIZE(8)
	 ) result_counter (
        .clk(clk),
        .rst(rst),
  		  .en(set),
        .target(OUT_DIM + 1),
        .count(last_result)
    );
	 
	 
    // Initialization during reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin	
		  		save_pixel = 0;
				
				  // Flatten the 3D array into the 1D array
				  index = 0;
				  for (int x = 0; x < KERNEL_DIM; x = x + 1) begin
						for (int y = 0; y < KERNEL_DIM; y = y + 1) begin
							 for (int z = 0; z < KERNEL_CH; z = z + 1) begin
								  flattened_weights[index] = Kernal_weights[x][y][z];
								  index = index + 1;
							 end
						end
				  end

            // Reset the array or other logic
            for (int i = 0; i < KERNEL_SIZE; i = i + 1) begin
				    group = i / (KERNEL_DIM * KERNEL_CH);
                in_read_addr[i] = ((group * KERNEL_SIZE) + (i % (KERNEL_DIM*IMG_CH)));
            end
        end else begin
			if ((current_pixel + 1) == IMG_SIZE) begin
				last = 1;
				end else begin
					last = 0;
				end
				
				if (last_result == OUT_DIM - 1)
				begin
					save_pixel = current_pixel;
				end  
		  end
    end

	 
	 always_comb begin
	      // Loop through each element of the array and add the value
        for (int j = 0; j < KERNEL_SIZE; j = j + 1) begin
            current_conv_addr[j] = in_read_addr[j] + (last_result-1)*(KERNEL_DIM*IMG_CH);
        end 
	
		 in_write_addr = current_pixel % BUFFER_SIZE;
	 
	    out_img_stream = 0;
		 for (int i = 0; i < KERNEL_SIZE; i = i + 1) begin
				out_img_stream = out_img_stream + (flattened_weights[i] * current_conv[i]);
		 end		  
		 
		 if (last_result > 0) begin
				if (last_result == OUT_DIM + 1) begin
					out_valid = 0;
					set = 0;			
				end else begin
					out_valid = 1;
					set = 1;
				end
	    end
		 else if ((save_pixel != current_pixel) && ((current_pixel) % BUFFER_SIZE) == 0 && (current_pixel) >= (IMG_DIM*IMG_CH*KERNEL_DIM) - 1) begin
				set = 1;
				out_valid = 0;
		 end
		 else if ((save_pixel != current_pixel) && (current_pixel)  == 0 && last) begin
				set = 1;
				out_valid = 0;
		 
		 end
		 else begin
		 		out_valid = 0;
				set = 0;
		 end
		 
    end

endmodule






