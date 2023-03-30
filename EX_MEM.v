//inSize: 1+2+4+32+26+1+32+32+32+5 = 167-bit
module EX_MEM (
    input clk,
    // WB
    input MemtoReg_in,
    input RegWrite_in,
    // M
    input [3:0] Branch_in,
    input Jump_in,
    input [1:0] MemWrite_in,
    input [2:0] MemRead_in,
    // Data
    input [31:0] PC_in,
    input [25:0] Jump_immed_in,
    input        Zero_in,
    input [31:0] ALURes_in,
    input [31:0] Data_Write_in,
    input [31:0] ExtOut_in,
    input [4:0]  Reg_Write_in,
    // Data Hazard
    input [4:0]  RegRt_in,
    input        ID_EX_IS_NOP,
    //overflow**
    input  overflow_in,//**
    input [31:0] OPC_in,
    input [4:0]EXCCODE_in,//#
    input[31:0]ins_in,//##

    // OUTPUT
    // WB
    output reg MemtoReg_out,
    output reg RegWrite_out,
    // M
    output reg  [3:0] Branch_out,
    output reg  Jump_out,
    output reg  [1:0] MemWrite_out,
    output reg  [2:0] MemRead_out,
    // Data
    output reg [31:0] PC_out,
    output reg [25:0] Jump_immed_out,
    output reg        Zero_out,
    output reg [31:0] ALURes_out,
    output reg [31:0] Data_Write_out,
    output reg [31:0] ExtOut_out,
    output reg [4:0]  Reg_Write_out,
    output reg [4:0]  RegRt_out   ,
    output reg        EX_MEM_IS_NOP ,
    //overflow**
    output reg overflow_out,//**
    output reg [31:0] OPC_out,
    output reg [4:0]EXCCODE_out,//#
    output reg [31:0] ins_out//##

);
    always @(posedge clk) begin
        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;
        Branch_out     <= Branch_in;
        Jump_out       <= Jump_in;
        MemWrite_out   <= MemWrite_in;
        MemRead_out    <= MemRead_in;
        PC_out         <= PC_in;
        Jump_immed_out <= Jump_immed_in;
        Zero_out       <= Zero_in;
        ALURes_out     <= ALURes_in;
        Data_Write_out <= Data_Write_in;
        ExtOut_out     <= ExtOut_in;
        Reg_Write_out  <= Reg_Write_in;
        RegRt_out      <= RegRt_in;
        EX_MEM_IS_NOP  <= ID_EX_IS_NOP;
        overflow_out   <= overflow_in;//**
        OPC_out        <= OPC_in;//**
        EXCCODE_out <=EXCCODE_in;//#
        ins_out <=ins_in;//##
    end

endmodule //EX_MEM