`include "./Para.v"
module Branch_PC (
    input [5:0]  Opcode,
    input [31:0] BEQ_immed,
    input [31:0] PC,

    output reg [31:0] BEQ_PC
);
    always @(Opcode or BEQ_immed) begin
        if(Opcode === `OP_BEQ)begin
            BEQ_PC = (BEQ_immed<<2) + PC;
        end     
    end

endmodule //Branch_PC