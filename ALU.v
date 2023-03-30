`include "./Para.v"

module alu (
    input [31:0] InputData1,    //rs
    input [31:0] InputData2,    //rt or Immediate
    input [`SIZE_ALUCTRLOUT:0] AluCtrlOut,
    // FIXME
    input [4:0] shamt, // 移位 instruction[10:6], 给sll, srl, sra

    output            Zero,
    output reg [31:0] AluRes
);

    always @(*) begin
        case(AluCtrlOut)
            `ALUCTRLOUT_ADD: AluRes = InputData1 + InputData2;
            `ALUCTRLOUT_SUB: AluRes = InputData1 - InputData2;
            `ALUCTRLOUT_AND: AluRes = InputData1 & InputData2;
            `ALUCTRLOUT_OR:  AluRes = InputData1 | InputData2;
            `ALUCTRLOUT_XOR: AluRes = InputData1 ^ InputData2;
            `ALUCTRLOUT_LUI: AluRes = {InputData2, 16'h0000};
            `ALUCTRLOUT_SLT: AluRes = (InputData1 < InputData2) ? 32'b1 : 32'b0;
            // FIXME
            `ALUCTRLOUT_SLL: begin
                AluRes = InputData2 << shamt;
            end
            `ALUCTRLOUT_SLLV: begin
                AluRes = InputData2 << InputData1[4:0];
            end
            `ALUCTRLOUT_SRL: begin
                AluRes = InputData2 >> shamt;
            end
            `ALUCTRLOUT_SRLV: begin
                AluRes = InputData2 >> InputData1[4:0];
            end
            `ALUCTRLOUT_SRA: begin
                AluRes = $signed(InputData2) >>> shamt;  // >>> 表示右移并补符号位，也就是算术右移
            end
            `ALUCTRLOUT_SRAV: begin
                AluRes = $signed(InputData2) >>> InputData1[4:0];
            end
            default:         AluRes = 31'bx;
        endcase
    end

    assign Zero = (AluRes==0) ? 1 : 0;

endmodule //alu