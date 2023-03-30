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
                    `FUNCT_ADDU: AluCtrlOut = `ALUCTRLOUT_ADDU;//*
                    `FUNCT_AND: AluCtrlOut = `ALUCTRLOUT_AND;
                    `FUNCT_OR:  AluCtrlOut = `ALUCTRLOUT_OR;
                    `FUNCT_SLT: AluCtrlOut = `ALUCTRLOUT_SLT;
                    `FUNCT_SLTU: AluCtrlOut = `ALUCTRLOUT_SLTU;//*
                    `FUNCT_SUB: AluCtrlOut = `ALUCTRLOUT_SUB;
                    `FUNCT_SUBU: AluCtrlOut = `ALUCTRLOUT_SUBU;//*
                    `FUNCT_XOR: AluCtrlOut = `ALUCTRLOUT_XOR;
                    `FUNCT_NOR: AluCtrlOut = `ALUCTRLOUT_NOR;//*
                    // 移位指令
                    `FUNCT_SLL: AluCtrlOut  = `ALUCTRLOUT_SLL;
                    `FUNCT_SLLV: AluCtrlOut = `ALUCTRLOUT_SLLV;
                    `FUNCT_SRL: AluCtrlOut  = `ALUCTRLOUT_SRL;
                    `FUNCT_SRLV: AluCtrlOut = `ALUCTRLOUT_SRLV;
                    `FUNCT_SRA: AluCtrlOut  = `ALUCTRLOUT_SRA;
                    `FUNCT_SRAV: AluCtrlOut = `ALUCTRLOUT_SRAV;
                endcase
            end

        `ALUOP_ADDI:  AluCtrlOut = `ALUCTRLOUT_ADDI;
        `ALUOP_ADDIU: AluCtrlOut = `ALUCTRLOUT_ADDIU;
        `ALUOP_LW:    AluCtrlOut = `ALUCTRLOUT_LW;
        `ALUOP_SW:    AluCtrlOut = `ALUCTRLOUT_SW;

        `ALUOP_Branch:   AluCtrlOut = `ALUCTRLOUT_Branch;

        `ALUOP_LUI:   AluCtrlOut = `ALUCTRLOUT_LUI;
        
        `ALUOP_ORI:   AluCtrlOut = `ALUCTRLOUT_ORI;

        `ALUOP_ANDI:  AluCtrlOut = `ALUCTRLOUT_ANDI;//*

        `ALUOP_XORI:  AluCtrlOut = `ALUCTRLOUT_XORI;//*

        `ALUOP_SLTI:  AluCtrlOut = `ALUCTRLOUT_SLTI;//*
        `ALUOP_SLTIU:  AluCtrlOut = `ALUCTRLOUT_SLTIU;//*
        default:      AluCtrlOut = `SIZE_ALUCTRLOUT'bx;
    endcase
end



endmodule //aluctrl