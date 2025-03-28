module Counter #(
    parameter int COUNTER_SIZE = 64
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [COUNTER_SIZE-1:0] target,
    output logic [COUNTER_SIZE-1:0] count
);
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (en) begin
            count <= (count == target - 1) ? 0 : count + 1;
        end
    end
    
endmodule
