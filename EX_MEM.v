//inSize: 1+2+4+32+26+1+32+32+32+5 = 167-bit
module EX_MEM (
    input clk,
    // WB
    input MemtoReg_in,
    input RegWrite_in,
    // M
    input Branch_in,
    input Jump_in,
    input MemWrite_in,
    input MemRead_in,
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

    // OUTPUT
    // WB
    output reg MemtoReg_out,
    output reg RegWrite_out,
    // M
    output reg  Branch_out,
    output reg  Jump_out,
    output reg  MemWrite_out,
    output reg  MemRead_out,
    // Data
    output reg [31:0] PC_out,
    output reg [25:0] Jump_immed_out,
    output reg        Zero_out,
    output reg [31:0] ALURes_out,
    output reg [31:0] Data_Write_out,
    output reg [31:0] ExtOut_out,
    output reg [4:0]  Reg_Write_out,
    output reg [4:0]  RegRt_out    

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
    end

endmodule //EX_MEM