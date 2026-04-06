module alu(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [4:0] M_control,
    output logic [31:0] Result,
    output logic Cout, 
    output logic V     
);

always_comb begin
    case (M_control)
        5'b00000: Result = A + B;                     // ADD
        5'b00001: Result = A - B;                     // SUB
        5'b00010: Result = A & B;                     // AND
        5'b00011: Result = A | B;                     // OR
        5'b00100: Result = A ^ B;                     // XOR
        5'b00101: Result = A << B[4:0];               // SLL (Shift by lower 5 bits of B)
        5'b00110: Result = A >> B[4:0];               // SRL
        5'b00111: Result = $signed(A) >>> B[4:0];     // SRA
        5'b01000: Result = {31'b0, $signed(A) < $signed(B)}; // SLT
        5'b01001: Result = {31'b0, A < B};            // SLTU
        default:  Result = 32'b0;
    endcase
end


assign Cout = 1'b0;
assign V = 1'b0;

endmodule