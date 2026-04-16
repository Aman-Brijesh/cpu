module cpu_core(
    input logic clk,
    input logic rst,
    output logic [31:0] final_result
);
    logic [31:0] reg1_data;
    logic [31:0] reg2_data;

    logic [4:0] alu_op_connect;

    logic [31:0] pc;
    logic [31:0] instruction;

    logic [31:0] i_out;
    logic [31:0] alu_B;
    logic ALUsrc;

    logic memRead;
    logic memWrite;
    logic [31:0] memory_read_data;
    logic checkMux;
    logic write_back_data;

    logic regWrite;

    logic branch;
    logic branch_taken;
    logic [2:0] branch_type;
    logic [31:0] branch_target;

    logic [31:0]next_pc;
    logic [31:0]pc_plus;

    assign pc_plus = pc+4;

    assign alu_B = (ALUsrc)? i_out:reg2_data;

    assign write_back_data = (checkMux) ? memory_read_data:final_result;

    assign branch_target = pc+i_out;

    assign next_pc = (branch_taken)? branch_target:pc_plus;

    always_comb begin
        branch_taken = 1'b0;

        if(branch) begin
            case (branch_type)
                3'b000: branch_taken = (reg1_data == reg2_data); // BEQ
                3'b001: branch_taken = (reg1_data != reg2_data); // BNE
                3'b100: branch_taken = ($signed(reg1_data) < $signed(reg2_data)); // BLT
                3'b101: branch_taken = ($signed(reg1_data) >= $signed(reg2_data)); // BGE
                default: branch_taken = 1'b0;
            endcase
        end
    end

    //program counter
    pc my_pc(
        .clk(clk),
        .rst(rst),
        .next_pc(next_pc),
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
        .alu_op(alu_op_connect),
        .memRead(memRead),
        .memWrite(memWrite),
        .checkMux(checkMux),
        .regWrite(regWrite),
        .branch(branch),
        .branch_type(branch_type),
        .ALUsrc(ALUsrc)
    );

    //register file
    register_file my_register_file(
        .clk(clk),
        .we(regWrite),
        .rs1(instruction[19:15]),
        .rs2(instruction[24:20]),
        .rd(instruction[11:7]),
        .wd(write_back_data),
        .rd1(reg1_data),
        .rd2(reg2_data)
    );

    //alu
    alu my_alu(
        .A(reg1_data),
        .B(alu_B),
        .M_control(alu_op_connect),
        .Result(final_result),
        .Cout(),
        .V()
    );
    
    //immediate generator
    immediate_generator my_immediate_generator(
        .instruction(instruction),
        .i_out(i_out)
    );

    data_memory my_data_memory(
        .clk(clk),
        .memWrite(memWrite),
        .memRead(memRead),
        .address(final_result),
        .write_data(reg2_data),
        .read_data(memory_read_data)
    );

endmodule