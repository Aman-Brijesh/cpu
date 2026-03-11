module instruction_decoder(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output [4:0] alu_op
);

localparam
ADD = 5'd0, //done
SUB = 5'd1, //done
AND = 5'd2, //done
OR = 5'd3, //done
XOR = 5'd4, //done
SLL = 5'd5, //done
SRL = 5'd6, //done
SRA = 5'd7, //done
SLT = 5'd8, //done
SLTU = 5'd9; //done

always_comb begin

    case(opcode)
            7'b0110011: begin
                case(funct3)
                    3'b000: begin
                        case (funct7)
                            7'b0000000: alu_op = ADD;
                            7'b0100000: alu_op = SUB;
                        endcase
                    end
                    3'b001: alu_op = SLL;
                    3'b010: alu_op = SLT;
                    3'b011: alu_op = SLTU;
                    3'b100: alu_op = XOR;
                    3'b101: begin
                        case (funct7)
                            7'b0000000: alu_op = SRL;
                            7'b0100000: alu_op = SRA;
                        endcase
                    end
                    3'b110: alu_op = OR;
                    3'b111: alu_op = AND;
                endcase
            end
            
            7'b0010011: begin 
                //need to continue
            end
    endcase
end




endmodule