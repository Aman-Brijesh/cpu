module alu(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [4:0] M_control,
    output logic [31:0] Result,
    output logic Cout,
    output logic V
);

logic [31:0] P;
logic [31:0] G;
logic [32:0] C;
logic Sub; 
assign Sub = (M_control == 5'b00001);

logic [31:0] B_sub;
assign B_sub = B^{32{Sub}};

assign G = A&B_sub;
assign P = A^B_sub;


//Sum
always @* begin
    C[0] = Sub;
    for(integer i = 0; i<32; i++) begin
        C[i+1] = G[i] | (P[i]&C[i]);
    end    
    Cout = C[32];
    V = Cout ^ C[31];
end

logic [31:0] sum;
assign sum = P^C[31:0];


//Mux
always_comb begin
    case (M_control)
        5'b00000: Result = sum;//add
        5'b00001: Result = sum;//sub
        5'b00010: Result = A&B;//and
        5'b00011: Result = A|B;//or
        5'b00100: Result = A^B;//XOR
        5'b00101: Result = A<<B;//SLL
        5'b00110: Result = A>>B;//SRL
        5'b00111: Result = $signed(A)>>>B;//SRA
        5'b01000: Result = $signed(A)<$signed(B);//SLT
        5'b01001: Result = A<B;//SLTU

        default: Result = 32'b0;
    endcase
end



endmodule
