module MemoryUnit #(
    parameter int Buffer_size = 24,
    parameter int N = 8
) (
    input  logic clk,  
    input  logic [7:0] in_addr,       // 64-bit input address for writing
    input  logic [7:0]  in_data,       // 8-bit data input for writing
    input  logic [7:0] read_addr [0:N-1],  // Array of read addresses
    output logic [7:0]  read_data [0:N-1]   // Output data array
);

    // 1D Buffer Memory
    logic [7:0] buffer [0:Buffer_size-1];

    // Write Logic
    always_ff @(posedge clk) begin
        buffer[in_addr] <= in_data;  // Store incoming data at given address
    end

    // Read Logic
    always_comb begin
        for (int i = 0; i < N; i++) begin
            read_data[i] = buffer[read_addr[i]];  // Read data from N addresses
        end
    end
	 

endmodule