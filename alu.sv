module alu(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [3:0] M_control,
    output logic [31:0] Result,
    output logic Cout,
    output logic V
);

logic [31:0] P;
logic [31:0] G;
logic [32:0] C;
logic Sub; 
assign Sub = (M_control == 4'b0001);

logic [31:0] B_sub;
assign B_sub = B^{32{Sub}};

assign G = A&B_sub;
assign P = A^B_sub;


//Sum
always_comb begin
    C[0] = Sub;
    for(int i = 0; i<32; i++) begin
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
        4'b0000: Result = sum;//add
        4'b0001: Result = sum;//sub
        4'b0010: Result = A&B;//and
        4'b0011: Result = A|B;//or
        4'b0100: Result = A^B;//XOR
        4'b0101: Result = A<<B;//SLL
        4'b0110: Result = A>>B;//SRL
        4'b0111: Result = $signed(A)>>>B;//SRA
        4'b1000: Result = $signed(A)<$signed(B);//SLT
        4'b1001: Result = A<B;//SLTU

        default: Result = 32'b0;
    endcase
end



endmodule
