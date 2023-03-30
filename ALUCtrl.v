`include "./Para.v"

module alu_ctrl (
    input [5:0] Funct,
    input [`SIZE_ALUOP:0] ALUOp,

    output reg [`SIZE_ALUCTRLOUT:0] AluCtrlOut
);

always @(*) begin
    case(ALUOp)
        `ALUOP_R:
            begin
                case(Funct)
                    `FUNCT_ADD: AluCtrlOut = `ALUCTRLOUT_ADD;
                    `FUNCT_AND: AluCtrlOut = `ALUCTRLOUT_AND;
                    `FUNCT_OR:  AluCtrlOut = `ALUCTRLOUT_OR;
                    `FUNCT_SLT: AluCtrlOut = `ALUCTRLOUT_SLT;
                    `FUNCT_SUB: AluCtrlOut = `ALUCTRLOUT_SUB;
                    `FUNCT_XOR: AluCtrlOut = `ALUCTRLOUT_XOR;
                    // FIXME
                    `FUNCT_SLL: AluCtrlOut = `ALUCTRLOUT_SLL;
                    `FUNCT_SLLV: AluCtrlOut = `ALUCTRLOUT_SLLV;
                    `FUNCT_SRL: AluCtrlOut = `ALUCTRLOUT_SRL;
                    `FUNCT_SRLV: AluCtrlOut = `ALUCTRLOUT_SRLV;
                    `FUNCT_SRA: AluCtrlOut = `ALUCTRLOUT_SRA;
                    `FUNCT_SRAV: AluCtrlOut = `ALUCTRLOUT_SRAV;
                endcase
            end

        `ALUOP_ADDI:  AluCtrlOut = `ALUCTRLOUT_ADDI;
        `ALUOP_ADDIU: AluCtrlOut = `ALUCTRLOUT_ADDIU;
        `ALUOP_LW:    AluCtrlOut = `ALUCTRLOUT_LW;
        `ALUOP_SW:    AluCtrlOut = `ALUCTRLOUT_SW;

        `ALUOP_BEQ:   AluCtrlOut = `ALUCTRLOUT_BEQ;

        `ALUOP_LUI:   AluCtrlOut = `ALUCTRLOUT_LUI;
        
        `ALUOP_ORI:   AluCtrlOut = `ALUCTRLOUT_ORI;
        default:      AluCtrlOut = `SIZE_ALUCTRLOUT'bx;
    endcase
end



endmodule //aluctrl