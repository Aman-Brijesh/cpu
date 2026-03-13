`timescale 1ns / 1ps

module tb_cpu_core();

    logic tb_clk;
    logic [31:0] tb_instruction;
    logic [31:0] tb_result;

    // Place down the motherboard
    cpu_core dut (
        .clk            (tb_clk),
        .instruction_in (tb_instruction),
        .final_result   (tb_result)
    );

    // Create the Master Clock
    always #5 tb_clk = ~tb_clk;

    initial begin
        // --- VCD DUMP ---
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_cpu_core);

        tb_clk = 0;
        tb_instruction = 0;

        // 1. THE BACKDOOR: Pre-load the Register File memory array!
        // This is a verification trick. We reach inside the 'dut', inside 'my_register_file', 
        // and force the memory array to hold our starting numbers.
        dut.my_register_file.memory_array[5]  = 32'd15;
        dut.my_register_file.memory_array[10] = 32'd2;
        #10;

        // 2. THE TEST: ADD x8, x5, x10
        // funct7(0000000) _ rs2(01010) _ rs1(00101) _ funct3(000) _ rd(01000) _ opcode(0110011)
        tb_instruction = 32'b0000000_01010_00101_000_01000_0110011;
        
        // Wait for the clock to tick and the ALU to do the math
        #10; 

        // Wait one more clock cycle to prove it saved into Register 8
        #10;

        $display("FINAL ALU RESULT: %0d", tb_result);
        $display("CHECKING MEMORY VAULT 8: %0d", dut.my_register_file.memory_array[8]);

        $finish;
    end
endmodule