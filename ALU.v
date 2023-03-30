`include "./Para.v"

module alu (
    input [31:0] InputData1,    //rs
    input [31:0] InputData2,    //rt or Immediate
    input [`SIZE_ALUCTRLOUT:0] AluCtrlOut,
    input [4:0] shamt,          // 移位 instruction[10:6], 给sll, srl, sra
    input Clock,Reset,//**

    output            Zero,
    output reg overflow,//**
    output reg [31:0] AluRes
);

    //**
    reg [32: 0] temp; 
    always @(posedge Clock or posedge Reset) begin
        overflow <= 0;   
    end

    always @(*) begin
        case(AluCtrlOut)
            `ALUCTRLOUT_ADD:begin 
                // AluRes = InputData1 + InputData2;
                temp = {InputData1[31], InputData1} + {InputData2[31], InputData2};
                if (temp[32:0] == {temp[31], temp[31:0]})
                begin
                    AluRes = temp;
                    overflow = 1'b0;
                end
                else 
                    overflow = 1'b1;
            end//**
            `ALUCTRLOUT_SUB: begin
                // AluRes = InputData1 - InputData2;
                temp = {InputData1[31], InputData1} - {InputData2[31], InputData2};
                if (temp[32:0] == {temp[31],temp[31:0]})
                begin
                    AluRes = temp;
                    overflow = 1'b0;
                end
                else 
                    overflow = 1'b1;
            end//**
            `ALUCTRLOUT_ADDU:AluRes = InputData1 + InputData2; 
            `ALUCTRLOUT_SUBU:AluRes = InputData1 - InputData2; 
            `ALUCTRLOUT_AND: AluRes = InputData1 & InputData2;
            `ALUCTRLOUT_OR:  AluRes = InputData1 | InputData2;
            `ALUCTRLOUT_XOR: AluRes = InputData1 ^ InputData2;
            `ALUCTRLOUT_NOR: AluRes = ~(InputData1 | InputData2);//*
            `ALUCTRLOUT_LUI: AluRes = {InputData2, 16'h0000};
            `ALUCTRLOUT_SLT:begin
                if ($signed(InputData1) < $signed(InputData2))
                    AluRes = 32'b1;
                else 
                    AluRes = 32'b0;
            end//*这个一开始应该是写错了，重新改了下
            `ALUCTRLOUT_SLTU: AluRes = (InputData1 < InputData2) ? 32'b1 : 32'b0;//*

            // 添加移位指令
            `ALUCTRLOUT_SLL: begin      // GPR[rd] ← GPR[rt] << instruction[10:6]
                AluRes = InputData2 << shamt;
            end
            `ALUCTRLOUT_SLLV: begin     // GPR[rd] ← GPR[rt] << GPR[rs][4:0]
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