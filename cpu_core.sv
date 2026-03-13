module cpu_core(
    input logic clk,
    input logic [31:0] instruction_in,
    output logic [31:0] final_result
);
    logic [31:0] reg1_data;
    logic [31:0] reg2_data;

    logic [4:0] alu_op_connect;
    logic write_enable = 1'b1;

    instruction_decoder my_decoder(
        .opcode(instruction_in[6:0]),
        .funct3(instruction_in[14:12]),
        .funct7(instruction_in[31:25]),
        .alu_op(alu_op_connect)
    );
    register_file my_register_file(
        .clk(clk),
        .we(write_enable),
        .rs1(instruction_in[19:15]),
        .rs2(instruction_in[24:20]),
        .rd(instruction_in[11:7]),
        .wd(final_result),
        .rd1(reg1_data),
        .rd2(reg2_data)
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