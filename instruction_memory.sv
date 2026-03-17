module instruction_memory(
    input logic [31:0] pc,
    output logic [31:0] instruction_out
);

    logic [31:0] memory[0:255];

    initial begin
        memory[0] = 32'h00500093;
        memory[1] = 32'h00700113;
        memory[2] = 32'h002081B3;
        for (int i = 3; i < 256; i++)
        memory[i] = 32'h00000033;
    end

    assign instruction_out = memory[pc[9:2]];


endmodule