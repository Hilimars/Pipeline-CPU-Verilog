/*  
    in_size: 1+32+32 = 65-bit
    out_size: 16+32 = 48-bit (X) 【更正】想错了，还是得传32位PC来
    PC的减少是因为后面BEQ指令想通过拼接来完成地址的定位。(X)
*/
module IF_ID (
    input  clk,
    input  [31:0] PC_in,
    input  [31:0] instr_in,
    // input  [31:0] PC_old,
    // input  [31:0] instr_old,
    input  Flush_Data,
    input  Flush_Ctrl,
    input  JR,
    input  ERET,
    input  Flag_Branch,
    input [31:0]OPC_in,//**
    input [4:0]EXCCODE_in,//#
    
    
    output reg [31:0] PC_out,
    output reg [31:0] instr_out,
    output reg        IF_ID_IS_NOP,
    output reg [31:0] OPC_out,//**
    output reg [4:0]EXCCODE_out//#
);
    always @(posedge clk) begin
        if(JR || Flag_Branch || ERET)// 添加NOP，不然在JR指令之后总会读取JR后一个指令进入ID阶段。
        begin
            PC_out <= PC_in;
            instr_out <= 32'h20080000;
            IF_ID_IS_NOP <= 1;
        end
        else if(!(Flush_Data || Flush_Ctrl))
        begin
            PC_out    <= PC_in;
            instr_out <= instr_in;
            IF_ID_IS_NOP <= 0;
            OPC_out <=OPC_in;//**
            EXCCODE_out <=EXCCODE_in;//#
        end
    end

//   always @(*) begin
//     if(Flush)
//     begin
//         instr_out <= 32'b0;
//         PC_out    <= 32'b0;
//     end

//   end

endmodule //IF_ID