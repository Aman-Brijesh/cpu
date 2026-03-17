module pc(
    input logic clk,
    input logic rst,
    output logic [31:0] pc
    
);

logic [31:0] pc_next;

assign pc_next = pc+4;

always_ff @( posedge clk or posedge rst) begin
    if(rst)
        pc <= 32'b0;
    else
        pc <= pc_next;
end
    



    
endmodule