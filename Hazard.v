`include "./Para.v"

module Hazard_Data (
    input [5:0] Opcode,
    input ID_EX_MR,
    input MEM_WB_MR,
    input [4:0] MEM_WB_RegRt,
    input [4:0] ID_EX_RegRs,
    input [4:0] ID_EX_RegRt,
    input [4:0] IF_ID_RegRs,
    input [4:0] IF_ID_RegRt,

    output reg IF_ID_Write_Zero,
    output reg PC_Sub_4,
    output reg Ctrl_0
    // output reg [1:0] ForwardA,
    // output reg [1:0] ForwardB

);
  initial
  begin
      IF_ID_Write_Zero = 0;
      PC_Sub_4 = 0;
      Ctrl_0   = 0;
  end
  always @(*) begin
    // Data Hazard
    // insert one bubble
    if(ID_EX_MR && (Opcode != `OP_BEQ) && (ID_EX_RegRt != 5'b0) && ((ID_EX_RegRt == IF_ID_RegRs) || (ID_EX_RegRt == IF_ID_RegRt)))  
    begin
      IF_ID_Write_Zero = 1;
      PC_Sub_4 = 1;
      Ctrl_0 = 1;
    end
    else
    begin
      IF_ID_Write_Zero = 0;
      PC_Sub_4 = 0;
      Ctrl_0   = 0;
    end


    // // 旁路
    // if(MEM_WB_MR && (MEM_WB_RegRt != 5'b0) && (MEM_WB_RegRt == ID_EX_RegRs))
    // begin
    //     ForwardA = 2'b01;
    // end

    // if(MEM_WB_MR && (MEM_WB_RegRt != 5'b0) && (MEM_WB_RegRt == ID_EX_RegRt))
    // begin
    //     ForwardB = 2'b01;
    // end
  end

endmodule //Hazard_Data

module Hazard_Control (
  input [5:0] Opcode,
  input ID_EX_RW,
  input ID_EX_MR,
  input EX_MEM_MR,
  input [4:0] IF_ID_RegRs,
  input [4:0] IF_ID_RegRt,
  input [4:0] ID_EX_RegRd,
  input [4:0] ID_EX_RegRt,
  input [4:0] EX_MEM_RegRd,

  output reg IF_ID_Write_Zero,
  output reg PC_Sub_4,
  output reg Ctrl_0
);

  initial
  begin
      IF_ID_Write_Zero = 0;
      PC_Sub_4 = 0;
      Ctrl_0   = 0;
  end

  always @(*) begin
    // add add beq
    if(Opcode === `OP_BEQ && ID_EX_RW && !ID_EX_MR && ((ID_EX_RegRd == IF_ID_RegRs) || (ID_EX_RegRd == IF_ID_RegRt) || (ID_EX_RegRt == IF_ID_RegRs) || (ID_EX_RegRt == IF_ID_RegRt)))
    begin
      IF_ID_Write_Zero = 1;
      PC_Sub_4 = 1;
      Ctrl_0   = 1;
    end

    // // begin
    // //   PC_Sub_4 = 0;
    // //   Ctrl_0   = 0;
    // // end

    // // lw lw beq
    // //和 Data Hazard重复了
    else if(Opcode === `OP_BEQ && ID_EX_MR && ((ID_EX_RegRt == IF_ID_RegRs) || (ID_EX_RegRt == IF_ID_RegRt)))
    begin
      IF_ID_Write_Zero = 1;
      PC_Sub_4 = 1;
      Ctrl_0   = 1;
    end
    else if(Opcode === `OP_BEQ && EX_MEM_MR && ((EX_MEM_RegRd == IF_ID_RegRs) || (EX_MEM_RegRd == IF_ID_RegRt)))
    begin
      IF_ID_Write_Zero = 1;
      PC_Sub_4 = 1;
      Ctrl_0   = 1;
    end
    else
    begin
      IF_ID_Write_Zero = 0;
      PC_Sub_4 = 0;
      Ctrl_0   = 0;
    end
  end

endmodule //Hazard_Control