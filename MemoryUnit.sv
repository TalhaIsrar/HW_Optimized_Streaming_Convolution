module MemoryUnit #(
    parameter int MEMORY_SIZE = 24,
    parameter int READ_ADDR_LEN = 8,
	 parameter int INPUT_PREC = 8
) (
    input  logic clk,
	 input  logic rst,
	 input  logic en,
    input  logic [INPUT_PREC - 1:0] in_addr,       // 64-bit input address for writing
    input  logic [INPUT_PREC - 1:0]  in_data,       // 8-bit data input for writing
    input  logic [INPUT_PREC - 1:0] read_addr [0:READ_ADDR_LEN-1],  // Array of read addresses
    output logic [INPUT_PREC - 1:0]  read_data [0:READ_ADDR_LEN-1]   // Output data array
);

    // 1D Buffer Memory
    logic [INPUT_PREC - 1:0] buffer [0:MEMORY_SIZE-1];

    always_ff @(posedge clk) begin
        if (en)  // Enable check
            buffer[in_addr] <= in_data;  // Store incoming data at given address
    end

    // Read Logic
    always_comb begin
        for (int i = 0; i < READ_ADDR_LEN; i++) begin
            read_data[i] = buffer[read_addr[i]];  // Read data from N addresses
        end
    end
	 

endmodule