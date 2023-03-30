/*  
    in_size: 1+32+32 = 65-bit
    out_size: 16+32 = 48-bit (X) 【更正】想错了，还是得传32位PC来
    PC的减少是因为后面BEQ指令想通过拼接来完成地址的定位。(X)
*/
module IF_ID (
    input  clk,
    input  [31:0] PC_in,
    input  [31:0] instr_in,
    input  [31:0] PC_old,
    input  [31:0] instr_old,
    input  Flush_Data,
    input  Flush_Ctrl,
    
    
    output reg [31:0] PC_out,
    output reg [31:0] instr_out
);
    always @(posedge clk) begin
        if(!(Flush_Data || Flush_Ctrl))
        begin
        PC_out    <= PC_in;
        instr_out <= instr_in;
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