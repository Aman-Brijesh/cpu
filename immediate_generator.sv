module immediate_generator(
    input logic [31:0] instruction,
    output logic [31:0] i_out
);


always_comb begin
    case (instruction)
        7'b0010011,
        7'b0000011: i_out = {{20{instruction[31]}},instruction[31:20]};
        7'b0100011: i_out = {{20{instruction[31]}},
                   instruction[31:25],
                   instruction[11:7]};
        default: i_out = 32'b0;
    endcase
end


endmodule