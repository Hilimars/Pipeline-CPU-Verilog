`include "./Para.v"

module Forward_DataHazard (
    input EX_MEM_RW,
    input MEM_WB_RW,
    input MEM_WB_MR,
    // input [4:0] MEM_WB_RegRt,
    input [4:0] EX_MEM_RegRd,
    input [4:0] MEM_WB_RegRd,
    input [4:0] ID_EX_RegRs,
    input [4:0] ID_EX_RegRt, 

    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);
  always @(*) begin
    // Data Hazard 

    if(EX_MEM_RW && (EX_MEM_RegRd != 5'b0) && EX_MEM_RegRd == ID_EX_RegRs)            ForwardA = 2'b10;    // ID_EX_Rs comes from ALURes
    // else if(MEM_WB_RW && (MEM_WB_RegRd != 5'b0) && !(EX_MEM_RW && (EX_MEM_RegRd != 5'b0) && EX_MEM_RegRd == ID_EX_RegRs) && (MEM_WB_RegRd == ID_EX_RegRs))     ForwardA = 2'b01; //ID_EX_Rs comes from DM Mux
    else if((MEM_WB_RW||MEM_WB_MR) && (MEM_WB_RegRd != 5'b0) && (MEM_WB_RegRd == ID_EX_RegRs))     ForwardA = 2'b01; //ID_EX_Rs comes from DM Mux
    else                                                                              ForwardA = 2'b00;

    if(EX_MEM_RW && (EX_MEM_RegRd != 5'b0) && EX_MEM_RegRd == ID_EX_RegRt)            ForwardB = 2'b10;    // ID_EX_Rt comes from ALURes
    // else if(MEM_WB_RW && (MEM_WB_RegRd != 5'b0) && !(EX_MEM_RW && (EX_MEM_RegRd != 5'b0) && EX_MEM_RegRd == ID_EX_RegRt) && (MEM_WB_RegRd == ID_EX_RegRt))     ForwardB = 2'b01; //ID_EX_Rt comes from DM Mux
    else if((MEM_WB_RW||MEM_WB_MR) && (MEM_WB_RegRd != 5'b0) && (MEM_WB_RegRd == ID_EX_RegRt))     ForwardB = 2'b01; //ID_EX_Rt comes from DM Mux
    else                                                                              ForwardB = 2'b00;
    
    // 旁路  融到(MEM_WB_RW||MEM_WB_MR)里面
    // if(MEM_WB_MR && (MEM_WB_RegRt != 5'b0) && (MEM_WB_RegRt == ID_EX_RegRs))
    // begin
    //     ForwardA = 2'b01;
    // end

    // if(MEM_WB_MR && (MEM_WB_RegRt != 5'b0) && (MEM_WB_RegRt == ID_EX_RegRt))
    // begin
    //     ForwardB = 2'b01;
    // end
  end

endmodule //Forward_DataHazard


module Forward_ControlHazard (
    input [5:0] Opcode,
    input [4:0] IF_ID_RegRs,
    input [4:0] IF_ID_RegRt,
    input [4:0] EX_MEM_RegRd,
    input       EX_MEM_MR,
    input [31:0]ALURes,

    output reg [1:0] ForwardC  // 01:Rs旁路  10:Rt旁路
);
    always @(*) begin
      // add beq
      if(Opcode === `OP_BEQ && (EX_MEM_RegRd != 5'b0) && !EX_MEM_MR && ALURes)
      begin
        if(EX_MEM_RegRd == IF_ID_RegRs)   ForwardC = 2'b01;
        else if(EX_MEM_RegRd == IF_ID_RegRt)   ForwardC = 2'b10;
        else ForwardC = 2'b00;
      end
    end
endmodule //Forward_ControlHazard