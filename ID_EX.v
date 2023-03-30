`include "./Para.v"
// inSize: 1+2+4+5+32+26+32+32+16+5+5 = 160-bit
module ID_EX (
    input clk,
    // WB
    input MemtoReg_in,
    input RegWrite_in,
    // M
    input Branch_in,
    input Jump_in,
    input MemWrite_in,
    input MemRead_in,
    //EX
    input RegDst_in,
    input ALUSrc_in,
    input ExtOp_in,
    input [`SIZE_ALUOP:0] ALUOp_in,
    //Data
    input [31:0] PC_in,
    input [25:0] Jump_immed_in,
    input [31:0] Reg_data_1_in,
    input [31:0] Reg_data_2_in,
    input [15:0] Ext_in,
    input [4:0]  rt_in,
    input [4:0]  rd_in,
    input [4:0]  rs_in,
    // FIXME
    input [4:0]  shamt_in,

    //OUTPUT
    // WB
    output reg MemtoReg_out,
    output reg RegWrite_out,
    // M
    output reg  Branch_out,
    output reg  Jump_out,
    output reg  MemWrite_out,
    output reg  MemRead_out,
    //EX
    output reg  RegDst_out,
    output reg  ALUSrc_out,
    output reg  ExtOp_out,
    output reg  [`SIZE_ALUOP:0] ALUOp_out,
    //Data
    output reg  [31:0] PC_out,
    output reg  [25:0] Jump_immed_out,
    output reg  [31:0] Reg_data_1_out,
    output reg  [31:0] Reg_data_2_out,
    output reg  [15:0] Ext_out,
    output reg  [4:0]  rt_out,
    output reg  [4:0]  rd_out,
    output reg  [4:0]  rs_out,
    // FIXME
    output reg  [4:0]  shamt_out
);
    always @(posedge clk) begin
        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;
        Branch_out     <= Branch_in;
        Jump_out       <= Jump_in;
        MemWrite_out   <= MemWrite_in;
        MemRead_out    <= MemRead_in;
        RegDst_out     <= RegDst_in;
        ALUSrc_out     <= ALUSrc_in;
        ExtOp_out      <= ExtOp_in;
        ALUOp_out      <= ALUOp_in;
        PC_out         <= PC_in;
        Jump_immed_out <= Jump_immed_in;
        Reg_data_1_out <= Reg_data_1_in;
        Reg_data_2_out <= Reg_data_2_in;
        Ext_out        <= Ext_in;
        rt_out         <= rt_in;
        rd_out         <= rd_in;
        rs_out         <= rs_in;
        // FIXME
        shamt_out      <= shamt_in;
    end
    initial begin
        // $monitor("ID_EX : RegWrite_in:%b, time %t",RegWrite_in,$time);
    end


endmodule //ID_EX