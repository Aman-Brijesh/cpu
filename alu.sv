module ALU(
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [1:0] M_control,
    output logic [31:0] result,
    output logic Cout,
    output logic V
);

logic [31:0] P;
logic [31:0] G;
logic [32:0] C;
logic Sub = (M_control ==2'b01);

logic [31:0] B_sub;
assign B_sub = B^{32{Sub}}

assign G = A&B;
assign P = A^B;

assign C[0] = Sub;

//Sum
always_comb begin
    for(int i = 0; i<32; i++) begin
        C[i+1] = G[i] | (P[i]&C[i]);
    end    
    assign Cout = C[32];
    V = Cout ^ C[31];
end

logic [31:0] sum;
assign sum = P^C[31:0]


//Mux
always_comb begin
    case (M_control)
        2'b00: Result = sum;
        2'b01: Result = sum;
        2'b10: Result = A&B;
        2'b11: Result = A|B; 
        default: Result = 32'b0;
    endcase
end



endmodule
