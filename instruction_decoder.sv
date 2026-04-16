module instruction_decoder(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [4:0] alu_op,
    output logic memRead,
    output logic memWrite,
    output logic checkMux,
    output logic regWrite,
    output logic branch,
    output logic [2:0]branch_type,
    output logic ALUsrc
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

    alu_op = ADD;
    ALUsrc = 1'b0;
    memRead = 1'b0;
    memWrite = 1'b0;
    checkMux = 1'b0;
    regWrite = 1'b0;
    branch = 1'b0;

    case(opcode)
            7'b0110011: begin //R-type Operations
                ALUsrc = 1'b0;
                regWrite = 1'b1;
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
            
            7'b0010011: begin //I-type operations
                ALUsrc = 1'b1;
                regWrite = 1'b1;
                case (funct3)
                3'b000: alu_op = ADD;
                3'b010: alu_op = SLT;
                3'b011: alu_op = SLTU;
                3'b100: alu_op = XOR;
                3'b110: alu_op = OR;
                3'b111: alu_op = AND;
                3'b001: alu_op = SLL;
                3'b101: begin
                    case (funct7)
                        7'b0000000: alu_op = SRL;
                        7'b0100000: alu_op = SRA;
                    endcase
                end
                endcase
            end
            7'b0000011: begin  //LW
                alu_op = ADD;
                ALUsrc = 1'b1;
                memRead = 1'b1;
                checkMux = 1'b1;
                regWrite = 1'b1;
            end

            7'b0100011: begin // SW
                alu_op = ADD;
                ALUsrc = 1'b1;
                memWrite = 1'b1;
            end
            7'b1100011: begin
                alu_op = SUB;
                branch = 1'b1;
                branch_type = funct3;
            end //Branch Operations, Will work on later
    endcase
end




endmodule