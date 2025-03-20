module Conv #(
	parameter int Kernal_Dim = 2,
	parameter int Kernal_Ch  = 3,
	parameter int Img_Dim	 = 4,
	parameter int Img_Ch		 = 3,
	parameter int Out_Dim    = 2
	// Currently stride = Kernal_Dim
)(
    input clk, rst,
    input logic [7:0] in_img_stream,
	 input logic in_valid,
    input logic [7:0] Kernal_weights [0:Kernal_Dim-1][0:Kernal_Dim-1][0:Kernal_Ch-1],
    output logic [15:0] out_img_stream,
	 output logic out_valid
);

	 logic [7:0] buffer [0:Img_Dim*Img_Ch*Kernal_Dim-1];
	 logic [7:0] in_read_addr [0:Kernal_Dim*Kernal_Dim*Img_Ch-1];
	 logic [7:0] current_conv_addr [0:Kernal_Dim*Kernal_Dim*Img_Ch-1];
	 logic [7:0] current_conv [0:Kernal_Dim*Kernal_Dim*Img_Ch-1];
	 logic [7:0] flattened_weights [0:Kernal_Dim*Kernal_Dim*Img_Ch-1];
	 reg [7:0] in_write_addr;
	 reg [7:0] out_block_addr;
	 reg [15:0] temp_result;
	 
	 Counter #(
		  .counter_size(8)
	 ) input_counter (
	 	 .clk(clk),
		 .rst(rst),
		 .en(in_valid),
		 .target(Img_Dim*Img_Ch*Kernal_Dim),
		 .count(in_write_addr)
	 );
	 
	 Counter #(
			.counter_size(8)
	 ) conv_counter (
        .clk(clk),
        .rst(rst),
  		  .en(in_valid),
        .target(Out_Dim),
        .count(out_block_addr)
    );
	 
	 
	 // Calculate addresses
    integer i, j;  // Loop variable
    integer group;  // To keep track of the current group

    // Initialization during reset
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            // Reset the array or other logic
            for (i = 0; i < Kernal_Dim*Kernal_Dim*Img_Ch; i = i + 1) begin
                group = i / (Kernal_Dim*Img_Ch);  // Determine the current group
                in_read_addr[i] = (group * Kernal_Dim*Kernal_Dim*Img_Ch) + (i % (Kernal_Dim*Img_Ch));  // Assign values based on group and index within group
            end
        end
    end
	 
	 always_comb begin
        // Loop through each element of the array and add the value
        for (j = 0; j < Kernal_Dim*Kernal_Dim*Img_Ch; j = j + 1) begin
            current_conv_addr[j] = in_read_addr[j] + out_block_addr*(Kernal_Dim*Img_Ch);
        end
    end
	 
	 MemoryUnit #(.Buffer_size(Img_Dim*Img_Ch*Kernal_Dim),
										 .N(Kernal_Dim*Kernal_Dim*Img_Ch)) 
	 internal_buffer(
		  .clk(clk),
		  .rst(rst),
		  .en(in_valid),
		  .in_addr(in_write_addr),
		  .in_data(in_img_stream),
		  .read_addr(current_conv_addr),
		  .read_data(current_conv)	  
	 );
	 
	 integer x, y, z;
	 integer index;
    always_comb begin
        // Flatten the 3D array into the 1D array
        index = 0;
        for (x = 0; x < Kernal_Dim; x = x + 1) begin
            for (y = 0; y < Kernal_Dim; y = y + 1) begin
                for (z = 0; z < Kernal_Ch; z = z + 1) begin
                    flattened_weights[index] = Kernal_weights[x][y][z];
                    index = index + 1;
                end
            end
        end
    end
	 
	 integer sum_i;
	 
	 always_comb begin
	    temp_result = 0;
		 for (sum_i = 0; sum_i< Kernal_Dim*Kernal_Dim*Img_Ch; sum_i = sum_i + 1) begin
				temp_result = temp_result + (flattened_weights[sum_i] * current_conv[sum_i]);
		 end
		 out_img_stream = temp_result;
    end
	 
	 always_comb begin
		 if (in_write_addr < Out_Dim) begin
				out_valid = 1;
		 end
		 else begin
		 		out_valid = 0;
		 end
	 end
	 
endmodule






