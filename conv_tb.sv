module conv_tb;
    // Parameters for the Conv module
    parameter int Kernal_Dim = 2;
    parameter int Kernal_Ch  = 3;
    parameter int Img_Dim    = 4;
    parameter int Img_Ch     = 3;
    parameter int Out_Dim    = 2;

    // Signals for the Conv module
    reg clk;
    reg rst;
    logic [7:0] in_img_stream;
    logic [7:0] Kernal_weights [0:Kernal_Dim-1][0:Kernal_Dim-1][0:Kernal_Ch-1];
    logic [7:0] out_img_stream;

    // Instantiate the Conv module
    Conv #(
        .Kernal_Dim(Kernal_Dim),
        .Kernal_Ch(Kernal_Ch),
        .Img_Dim(Img_Dim),
        .Img_Ch(Img_Ch),
        .Out_Dim(Out_Dim)
    ) uut (
        .clk(clk),
        .rst(rst),
        .in_img_stream(in_img_stream),
        .Kernal_weights(Kernal_weights),
        .out_img_stream(out_img_stream)
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
        // Random initialization of Kernal_weights
        // You can change the seed or value ranges to fit your needs
        for (int i = 0; i < Kernal_Dim; i = i + 1) begin
            for (int j = 0; j < Kernal_Dim; j = j + 1) begin
                for (int k = 0; k < Kernal_Ch; k = k + 1) begin
                    Kernal_weights[i][j][k] = i;  // Random 8-bit value
                end
            end
        end

        // Apply reset
        rst = 1;
        #10;  // Wait for a few clock cycles
        rst = 0;
        
        // Apply image stream (Img_Dim * Img_Dim * Img_Ch = 4 * 4 * 3 = 48 cycles)
        for (int i = 0; i < Img_Dim * Img_Dim * Img_Ch; i = i + 1) begin
            in_img_stream = i;  // Random 8-bit input for the image stream
            #10;  // Wait for the next clock cycle
        end

        // Wait a bit for the convolution to complete
        #100;

        // Observe the output (you can add assertions or print the value)
        $display("Output Image Stream: %h", out_img_stream);
        
        // End the simulation
        $stop;
    end

endmodule
