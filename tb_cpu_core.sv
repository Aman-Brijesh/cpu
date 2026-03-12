`timescale 1ns / 1ps

module tb_cpu_core();

    // 1. Wires to plug into the motherboard
    logic [31:0] tb_instruction;
    logic [31:0] tb_reg1;
    logic [31:0] tb_reg2;
    logic [31:0] tb_result;

    // 2. Place down the Motherboard (DUT)
    cpu_core dut (
        .instruction_in (tb_instruction),
        .reg1_data      (tb_reg1),
        .reg2_data      (tb_reg2),
        .final_result   (tb_result)
    );

    // 3. Inject instructions and electricity
    initial begin
        // ========================================================
        // PART 1: Standard Positive Math
        // reg1 = 15.0000, reg2 = 2.0000
        // ========================================================
        tb_reg1 = 32'd15;
        tb_reg2 = 32'd2;

        $display("--- PART 1: Standard Math (15.0000 and 2.0000) ---");

        // 1. ADD (15.0000 + 2.0000 = 17.0000)
        tb_instruction = 32'b0000000_00000_00000_000_00000_0110011; #10; 
        $display("1. ADD Result: %0d.0000", tb_result);
        
        // 2. SUB (15.0000 - 2.0000 = 13.0000)
        tb_instruction = 32'b0100000_00000_00000_000_00000_0110011; #10; 
        $display("2. SUB Result: %0d.0000", tb_result);

        // 3. AND (15.0000 & 2.0000 = 2.0000)
        tb_instruction = 32'b0000000_00000_00000_111_00000_0110011; #10;
        $display("3. AND Result: %0d.0000", tb_result);

        // 4. OR (15.0000 | 2.0000 = 15.0000)
        tb_instruction = 32'b0000000_00000_00000_110_00000_0110011; #10;
        $display("4. OR  Result: %0d.0000", tb_result);

        // 5. XOR (15.0000 ^ 2.0000 = 13.0000)
        tb_instruction = 32'b0000000_00000_00000_100_00000_0110011; #10;
        $display("5. XOR Result: %0d.0000", tb_result);

        // 6. SLL - Shift Left (15.0000 << 2.0000 = 60.0000)
        tb_instruction = 32'b0000000_00000_00000_001_00000_0110011; #10;
        $display("6. SLL Result: %0d.0000", tb_result);

        // 7. SRL - Shift Right Logical (15.0000 >> 2.0000 = 3.0000)
        tb_instruction = 32'b0000000_00000_00000_101_00000_0110011; #10;
        $display("7. SRL Result: %0d.0000", tb_result);


        // ========================================================
        // PART 2: Signed vs Unsigned Math 
        // reg1 = -16.0000, reg2 = 2.0000
        // ========================================================
        tb_reg1 = -16; 
        tb_reg2 = 32'd2;

        $display("\n--- PART 2: Signed Math (-16.0000 and 2.0000) ---");

        // 8. SRA - Shift Right Arithmetic (-16.0000 >>> 2.0000 = -4.0000)
        tb_instruction = 32'b0100000_00000_00000_101_00000_0110011; #10;
        $display("8. SRA Result: %0d.0000", $signed(tb_result));

        // 9. SLT - Set Less Than Signed (-16.0000 < 2.0000 = 1.0000)
        tb_instruction = 32'b0000000_00000_00000_010_00000_0110011; #10;
        $display("9. SLT Result: %0d.0000", tb_result);

        // 10. SLTU - Set Less Than Unsigned (4294967280.0000 < 2.0000 = 0.0000)
        tb_instruction = 32'b0000000_00000_00000_011_00000_0110011; #10;
        $display("10. SLTU Result: %0d.0000", tb_result);

        $finish;
    end
endmodule