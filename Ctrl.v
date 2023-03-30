`include "./Para.v"

module ctrl (
    input [31:26] Opcode,
    input         Ctrl_0_Ctrl,
    input         Ctrl_0_Data,

    output reg                  RegDst,    // 1: write data to rd[15:11](R-Type);  0: write data to rt[20:16](I-Type) or False
    output reg                  Jump,      // 1: jump instruction
    output reg                  Branch,    // 1: beq instruction
    output reg                  MemRead,   // 1: read memory data 
    output reg                  MemtoReg,  // 1: data from memory;  0: data from ALU
    output reg [`SIZE_ALUOP:0]  ALUOp,     
    output reg                  MemWrite,  // 1: write data to memory 
    output reg                  ALUSrc,    // 1: data from register;  0: data from immediate 
    output reg                  RegWrite,  // 1: write data to register
    output reg                  ExtOp      // 1: signed extend;  0: unsigned extend or False
);

    initial begin
        // $display("can reach ctrl !");
    end
    //just for easy
    `define SIGNAL {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, ExtOp}
    always @(*) begin
        // $display("ctrl changed!, Opcode is %b",Opcode);
        if((Ctrl_0_Ctrl == 1'b1) || (Ctrl_0_Data == 1'b1))
            `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_0, 1'b0, 1'b0, 1'b0, 1'b0};
        else if(Opcode == `OP_R)
        // if(Opcode == `OP_R)x
            `SIGNAL = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_R, 1'b0, 1'b1, 1'b1, 1'b1};
        else
            case(Opcode)
                `OP_ADDIU: `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_ADDIU, 1'b0, 1'b0, 1'b1, 1'b0}; // 000000100010
                `OP_ADDI:  `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_ADDI , 1'b0, 1'b0, 1'b1, 1'b1}; // 000000100011
                `OP_ORI:   `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_ORI  , 1'b0, 1'b0, 1'b1, 1'b0};
                `OP_LUI:   `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_LUI  , 1'b0, 1'b0, 1'b1, 1'b0};
                `OP_LW:    `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, `ALUOP_LW   , 1'b0, 1'b0, 1'b1, 1'b0};
                `OP_SW:    `SIGNAL = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, `ALUOP_SW   , 1'b1, 1'b0, 1'b0, 1'b0};
                `OP_BEQ:   `SIGNAL = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, `ALUOP_BEQ  , 1'b0, 1'b1, 1'b0, 1'b1};
                `OP_J:     `SIGNAL = {1'b0, 1'b1, 1'b0, 1'b0, 1'b0, `ALUOP_J    , 1'b0, 1'b0, 1'b0, 1'b0};
            endcase
        // $display("%b",`SIGNAL);
    end

endmodule //ctrl