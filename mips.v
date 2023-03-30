`include "./Para.v"
`include "./DataPath.v"
`include "./Ctrl.v"

module Mips (clk, rst);
    input   clk;
    input   rst;

    wire [31:0] Instruction;
   
    wire                    RegDst;
    wire                    Jump;
    wire                    Branch;
    wire                    MemRead;
    wire                    MemtoReg;
    wire   [`SIZE_ALUOP: 0] ALUOp;
    wire                    MemWrite;
    wire                    ALUSrc;
    wire                    RegWrite;
    wire                    ExtOp;
    wire                    ctrl_0_Ctrl;
    wire                    ctrl_0_Data;

    initial begin
        // $monitor("Mips : RegWrite:%b, time %t",RegWrite,$time);
    end

    data_path DataPath(
        .RegDst(RegDst), 
        .Jump(Jump), 
        .Branch(Branch), 
        .MemRead(MemRead),  
        .MemtoReg(MemtoReg), 
        .ALUOp(ALUOp), 
        .MemWrite(MemWrite), 
        .ALUSrc(ALUSrc), 
        .RegWrite(RegWrite), 
        .ExtOp(ExtOp), 
        .Clock(clk), 
        .Reset(rst), 

        .IF_ID_instr_out(Instruction),
        .Ctrl_0_Ctrl(ctrl_0_Ctrl),
        .Ctrl_0_Data(ctrl_0_Data)
    );

    ctrl Controller(
        .Opcode(Instruction[31:26]),
        .Ctrl_0_Ctrl(ctrl_0_Ctrl),
        .Ctrl_0_Data(ctrl_0_Data),

        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ExtOp(ExtOp)
    );
endmodule //mips