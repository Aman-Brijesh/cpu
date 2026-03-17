module cpu_core(
    input logic clk,
    input logic rst,
    output logic [31:0] final_result
);
    logic [31:0] reg1_data;
    logic [31:0] reg2_data;

    logic [4:0] alu_op_connect;
    logic write_enable = 1'b1;

    logic [31:0] pc;
    logic [31:0] instruction;

    //program counter
    pc my_pc(
        .clk(clk),
        .rst(rst),
        .pc(pc)
    );

    //instruction memory
    instruction_memory my_instruction_memory(
        .pc(pc),
        .instruction_out(instruction)
    );
    
    //decoder
    instruction_decoder my_decoder(
        .opcode(instruction[6:0]),
        .funct3(instruction[14:12]),
        .funct7(instruction[31:25]),
        .alu_op(alu_op_connect)
    );

    //register file
    register_file my_register_file(
        .clk(clk),
        .we(write_enable),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .wd(final_result),
        .rd1(reg1_data),
        .rd2(reg2_data)
    );

    //alu
    alu my_alu(
        .A(reg1_data),
        .B(reg2_data),
        .M_control(alu_op_connect),
        .Result(final_result),
        .Cout(),
        .V()
    );

endmodule