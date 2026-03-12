module cpu_core(
    input logic [31:0] instruction_in,
    input logic [31:0] reg1_data,
    input logic [31:0] reg2_data,
    output logic [31:0] final_result
);

    logic [4:0] alu_op_connect;

    instruction_decoder my_decoder(
        .opcode(instruction_in[6:0]),
        .funct3(instruction_in[14:12]),
        .funct7(instruction_in[31:25]),
        .alu_op(alu_op_connect)
    );

    alu my_alu(
        .A(reg1_data),
        .B(reg2_data),
        .M_control(alu_op_connect),
        .Result(final_result),
        .Cout(),
        .V()
    );

endmodule