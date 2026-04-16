module pc(
    input logic clk,
    input logic rst,
    output logic [31:0] next_pc
    output logic [31:0] pc
);


always_ff @( posedge clk or posedge rst) begin
    if(rst)
        pc <= 32'b0;
    else
        pc <= next_pc;
end
    



    
endmodule