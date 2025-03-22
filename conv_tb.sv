module conv_tb;
    // Parameters for the Conv module
    parameter int KERNEL_DIM = 2;
    parameter int KERNEL_CH  = 3;
    parameter int IMG_DIM    = 4;
    parameter int IMG_CH     = 3;
    parameter int OUT_DIM    = 2;
	 parameter int INPUT_PREC = 8;

    // Signals for the Conv module
    reg clk;
    reg rst;
    logic [INPUT_PREC - 1:0] in_img_stream;
	 logic in_valid;
    logic [INPUT_PREC - 1:0] Kernal_weights [0:KERNEL_DIM-1][0:KERNEL_DIM-1][0:KERNEL_CH-1];
    logic [INPUT_PREC*2 - 1:0] out_img_stream;
	 logic out_valid;
	 
	 int count;

    // Instantiate the Conv module
    Conv #(
        .KERNEL_DIM(KERNEL_DIM),
        .KERNEL_CH(KERNEL_CH),
        .IMG_DIM(IMG_DIM),
        .IMG_CH(IMG_CH),
        .OUT_DIM(OUT_DIM),
		  .INPUT_PREC(INPUT_PREC)
    ) uut (
        .clk(clk),
        .rst(rst),
        .in_img_stream(in_img_stream),
		  .in_valid(in_valid),
        .Kernal_weights(Kernal_weights),
        .out_img_stream(out_img_stream),
		  .out_valid(out_valid)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // 10 ns clock period
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        in_img_stream = 0;
		  in_valid = 0;
        for (int i = 0; i < KERNEL_DIM; i = i + 1) begin
            for (int j = 0; j < KERNEL_DIM; j = j + 1) begin
                for (int k = 0; k < KERNEL_CH; k = k + 1) begin
                    Kernal_weights[i][j][k] = i+j+k;  // Random 8-bit value
                end
            end
        end

        // Apply reset
        rst = 1;
        #10;  // Wait for a few clock cycles
        rst = 0;
        in_valid = 1;
		  
        for (count = 0; count < ((IMG_DIM * IMG_DIM * IMG_CH))-2/2; count++) begin
            in_img_stream = count;
            #10;
        end
		  in_valid = 0;
		  #50
		  in_valid = 1;
		  
		  
        for (count = in_img_stream + 1; count < IMG_DIM * IMG_DIM * IMG_CH; count++) begin
            in_img_stream = count;
            #10;
        end
		  in_valid = 0;


        // Wait a bit for the convolution to complete
        #100;
		  in_valid = 1;
        for (count = (IMG_DIM * IMG_DIM * IMG_CH) - 1; count > ((IMG_DIM * IMG_DIM * IMG_CH)-2)/2; count--) begin
            in_img_stream = count;
            #10;
        end
		  in_valid = 0;
		  #30
		  in_valid = 1;
		  
		  
        for (count = in_img_stream - 1; count >= 0; count--) begin
            in_img_stream = count;
            #10;
        end
		  
		  
        for (count = 0; count < ((IMG_DIM * IMG_DIM * IMG_CH))/2; count++) begin
            in_img_stream = count;
            #10;
        end
		  in_valid = 0;
		  #50
		  in_valid = 1;
		  
		  
        for (count = in_img_stream + 1; count < IMG_DIM * IMG_DIM * IMG_CH; count++) begin
            in_img_stream = count;
            #10;
        end
		  in_valid = 0;
		   
		  #100

        // End the simulation
        $stop;
    end

endmodule
