// Mux by RegDst
module mux_by_RegDst(
    input [4:0] rt,
    input [4:0] rd,
    input       RegDst,

    output reg [4:0] DstReg
);
    always @(*) begin
        if(RegDst)
            DstReg <= rd;
        else
            DstReg <= rt;
    end


endmodule

// Mux by ALUSrc
module mux_by_ALUSrc(
    input [31:0] rtData,
    input [31:0] Immediate,
    input        ALUSrc,

    output reg [31:0] DstData
);
    always @(*) begin
        if(ALUSrc)
            DstData <= rtData;
        else    
            DstData <= Immediate;
    end

endmodule

// Mux by MemToReg
module mux_by_MemToReg(
    input [31:0] DmData,
    input [31:0] ALUData,
    input        MemtoReg,

    output reg [31:0] DstData
);
    always @(*) begin
        if(MemtoReg)
            DstData <= DmData;
        else
            DstData <= ALUData;
    end
endmodule

// Mux ForwardA
module mux_by_ForwardA(
    input [1:0] ForwardA,
    input [31:0] Mux_DM,
    input [31:0] Data_rs,
    input [31:0] ALURes,

    output reg [31:0] ForwardA_Rs_ALU
);

  always @(*) begin
    case(ForwardA)
        2'b01:   ForwardA_Rs_ALU <= Mux_DM;
        2'b10:   ForwardA_Rs_ALU <= ALURes;
        default: ForwardA_Rs_ALU <= Data_rs;
    endcase
  end

endmodule

// Mux ForwardB
module mux_by_ForwardB(
    input [1:0] ForwardB,
    input [31:0] Mux_DM,
    input [31:0] Data_rt,
    input [31:0] ALURes,

    output reg [31:0] ForwardB_Rt_ALU
);

  always @(*) begin
    case(ForwardB)
        2'b01:   ForwardB_Rt_ALU <= Mux_DM;
        2'b10:   ForwardB_Rt_ALU <= ALURes;
        default: ForwardB_Rt_ALU <= Data_rt;
    endcase
  end

endmodule

module mux_by_ForwardC(
    input clk,
    input [1:0] ForwardC,
    input [31:0] EX_MEM_ALURes,
    input [31:0] Rs,
    input [31:0] Rt,

    output reg [31:0] BEQ_Rs,
    output reg [31:0] BEQ_Rt
);
    // always @(negedge clk) begin
    always @(*) begin
    // add beq
    case(ForwardC)
    2'b01:
        begin
            BEQ_Rs <= EX_MEM_ALURes;
            BEQ_Rt <= Rt;
        end
    2'b10:
        begin
            BEQ_Rt <= EX_MEM_ALURes;
            BEQ_Rs <= Rs;
        end
    default:
        begin
            BEQ_Rs <= Rs;
            BEQ_Rt <= Rt;
        end
    endcase
    end
   

endmodule //mux_by_ForwardC