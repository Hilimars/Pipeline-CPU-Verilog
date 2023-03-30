`include "./Para.v"
`include "./DataPath.v"
`include "./Ctrl.v"

module Mips (clk, rst);
    input   clk;
    input   rst;

    wire [31:0] Instruction;
   
    wire   [1:0]            RegDst;
    wire                    Jump;
    wire   [3:0]            Branch;
    wire   [2:0]            MemRead;
    wire                    MemtoReg;
    wire   [`SIZE_ALUOP: 0] ALUOp;
    wire   [1:0]            MemWrite;
    wire                    ALUSrc;
    wire                    RegWrite;
    wire                    ExtOp;
    wire                    ctrl_0_Ctrl;
    wire                    ctrl_0_Data;
    wire                    DataDst;
    wire                    JR;
    wire                    ERET;
    wire  [`SIZE_EXCCODE:0] EXCCODE;//#

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
        .DataDst(DataDst),
        .Clock(clk), 
        .Reset(rst), 
        .JR(JR),
        .ERET(ERET),
        .EXCCODE(EXCCODE),//#

        .IF_ID_instr_out(Instruction),
        .Ctrl_0_Ctrl(ctrl_0_Ctrl),
        .Ctrl_0_Data(ctrl_0_Data)
    );

    ctrl Controller(
        .Opcode(Instruction[31:26]),
        .Ctrl_0_Ctrl(ctrl_0_Ctrl),
        .Ctrl_0_Data(ctrl_0_Data),
        .Funct(Instruction[5:0]),
        .rs(Instruction[25:21]),
        .rt(Instruction[20:16]),

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
        .DataDst(DataDst),
        .JR(JR),
        .ERET(ERET),
        .EXCCODE(EXCCODE)//#
    );
endmodule //mips