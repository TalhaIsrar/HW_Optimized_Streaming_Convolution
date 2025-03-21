module Counter #(
    parameter int counter_size = 64
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic [counter_size -1:0] target,  // Target count value
    output logic [counter_size -1:0] count
);
    
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (en) begin
            if (count < target - 1)
                count <= count + 1;
            else
                count <= 0;  // Reset counter when reaching target
        end
    end
    
endmodule
