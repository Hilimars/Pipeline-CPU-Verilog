// inSize: 1+2+32+32+5 = 72-bit
module MEM_WB (
    input clk,
    // WB
    input MemtoReg_in,
    input RegWrite_in,
    //Hazard
    input MemRead_in,
    // Data
    input [31:0] Mem_Data_in,
    input [31:0] ALU_Data_in,
    input [4:0]  Reg_Write_in,
    // Data Hazard
    input [4:0]  RegRt_in,

    //OUTPUT
    // WB
    output reg MemtoReg_out,
    output reg RegWrite_out,
    output reg MemRead_out,
    // Data
    output reg [31:0] Mem_Data_out,
    output reg [31:0] ALU_Data_out,
    output reg [4:0]  Reg_Write_out,
    output reg [4:0]  RegRt_out    
);

    always @(posedge clk) begin
        MemtoReg_out   <= MemtoReg_in;
        RegWrite_out   <= RegWrite_in;
        MemRead_out    <= MemRead_in;
        Mem_Data_out   <= Mem_Data_in;
        ALU_Data_out   <= ALU_Data_in;
        Reg_Write_out  <= Reg_Write_in;
        RegRt_out      <= RegRt_in;

    end
endmodule //MEM_WB