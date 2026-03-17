module register_file(
    input logic clk,
    input logic we, //write enable
    input logic [4:0] rs1, //address of the first register
    input logic [4:0] rs2, //address of second register
    input logic [4:0] rd, //address of destination register
    input logic [31:0] wd, //the data we store
    output logic [31:0] rd1,
    output logic [31:0] rd2
);

logic [31:0] memory_array [31:0];

initial begin
    for (int i = 0; i < 32; i++)
        memory_array[i] = 32'b0;
end

assign rd1 = (rs1 == 5'b00000)?32'b0:memory_array[rs1];
assign rd2 = (rs2 == 5'b00000)?32'b0:memory_array[rs2];


always_ff @( posedge clk ) begin
    if (we & rd!= 5'b00000) begin
        memory_array[rd]<=wd;
    end
end

endmodule