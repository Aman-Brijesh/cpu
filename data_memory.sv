module data_memory(
    input logic clk,
    input logic memWrite,
    input logic memRead,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);

    logic [31:0] memory[0:255];

    always_ff (@ posedge clk) begin
        if(memWrite)
            memory[address[9:2]]<=write_data;
    end
    always_comb begin
        if(memRead)
            read_data = memory[address[9:2]];
        else
            read_data = 32'b0;  
    end


endmodule