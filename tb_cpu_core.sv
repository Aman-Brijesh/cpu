module tb_cpu_core;

    logic clk;
    logic rst;

    logic [31:0] final_result;

    // Instantiate CPU
    cpu_core dut (
        .clk(clk),
        .rst(rst),
        .final_result(final_result)
    );

    // Clock generation (10 time unit period)
    always #5 clk = ~clk;

    // Simulation control
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Apply reset
        #10;
        rst = 0;

        // Run simulation for some time
        #100;

        // Print result
        $display("Final Result = %0d", final_result);

        // End simulation
        $finish;
    end

    // Optional monitoring (prints every change)
    initial begin
        $monitor("Time = %0t | PC = %0d | Result = %0d", 
                 $time, dut.pc, final_result);
    end

endmodule