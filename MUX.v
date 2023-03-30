// Mux by RegDst
module mux_by_RegDst(
    input [4:0] rt,
    input [4:0] rd,
    input [1:0] RegDst,

    output reg [4:0] DstReg
);
    always @(*) begin
        case (RegDst)
            2'b00: DstReg = rt;
            2'b01: DstReg = rd;
            2'b10: DstReg = 31;
        endcase
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

// Mux by DataDst
// 置于EX_MEM之前，判断存入的是ALU结果还是PC+4，为跳转指令设计
module mux_by_DataDst(
    input [31:0] ALURes,
    input [31:0] ID_EX_PC_out,
    input        DataDst,

    output reg [31:0] Data_out
);
    always @(*) begin
        if(DataDst)
            Data_out <= ID_EX_PC_out;
        else    
            Data_out <= ALURes;
    end

endmodule

// Mux by MemToReg
//**
module mux_by_MemToReg(
    input [31:0] DmData,
    input [31:0] ALUData,
    input        MemtoReg,
    input overflow,//**

    output reg [31:0] DstData
);
    always @(*) begin
        if(MemtoReg)//||overflow)
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

    output reg [31:0] Branch_Rs,
    output reg [31:0] Branch_Rt
);
    // always @(negedge clk) begin
    always @(*) begin
    // add beq
    case(ForwardC)
    2'b01:
        begin
            Branch_Rs <= EX_MEM_ALURes;
            Branch_Rt <= Rt;
        end
    2'b10:
        begin
            Branch_Rt <= EX_MEM_ALURes;
            Branch_Rs <= Rs;
        end
    default:
        begin
            Branch_Rs <= Rs;
            Branch_Rt <= Rt;
        end
    endcase
    end
   

endmodule //mux_by_ForwardC