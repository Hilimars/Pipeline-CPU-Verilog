`include "./Para.v"

module ctrl (
    input [31:26] Opcode,
    input         Ctrl_0_Ctrl,
    input         Ctrl_0_Data,
    input [5:0]   Funct,
    input [4:0]   rs,
    input [4:0]   rt,
    output reg            [1:0] RegDst,    // 01: write data to rd[15:11](R-Type);  00: write data to rt[20:16](I-Type) or False ; 
                                           // 10: write data to GPR[31], that is $ra
    output reg                  Jump,      // 1: jump instruction
    output reg            [3:0] Branch,    // 1: beq instruction
    output reg            [2:0] MemRead,   // read memory data      000:非l, 001:lb, 010:lbu, 011:lh, 100:lhu, 101:lw
    output reg                  MemtoReg,  // 1: data from memory;  0: data from ALU
    output reg [`SIZE_ALUOP:0]  ALUOp,     
    output reg            [1:0] MemWrite,  // write data to memory  00:非s, 01:sb, 10:sh, 11:sw 
    output reg                  ALUSrc,    // 1: data from register;  0: data from immediate 
    output reg                  RegWrite,  // 1: write data to register
    output reg                  ExtOp,     // 1: signed extend;  0: unsigned extend or False
    output reg                  DataDst,   // 1: choose pc_add_out to GPR;  0: choose ALURes to GPR
    output reg                  JR,
    output reg                  ERET,
    output reg [`SIZE_EXCCODE:0] EXCCODE//#
);

    initial begin
        // $display("can reach ctrl !");
    end
    //just for easy
    `define SIGNAL {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, ExtOp, DataDst, JR,EXCCODE,ERET}//#

    always @(*) begin
        // $display("ctrl changed!, Opcode is %b",Opcode);
        if((Ctrl_0_Ctrl == 1'b1) || (Ctrl_0_Data == 1'b1))
            `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
        else if(Opcode == `OP_R)
        // if(Opcode == `OP_R)x
            case(Funct)
                `FUNCT_JR:  `SIGNAL = {2'b10, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1,`EXC_NOT,1'b0};
                `FUNCT_JALR:`SIGNAL = {2'b10, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1,`EXC_NOT,1'b0}; // rd为存入寄存器地址，存入pc+4
                `FUNCT_SYSCALL: `SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_SYSCALL,1'b0};//#
                `FUNCT_BREAK: `SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_BREAK,1'b0};//#
                //##
                `FUNCT_ADD:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_ADDU:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SUB:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SUBU:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SLT:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SLTU:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_AND:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_OR:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_NOR:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_XOR:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SLL:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SLLV:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SRL:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SRLV:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SRA:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `FUNCT_SRAV:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};

                default:`SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_UNDEFINE,1'b0};
            endcase
        else
            case(Opcode)
                `OP_ADDIU: `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_ADDIU, 2'b00, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0}; // 000000100010
                `OP_ADDI:  `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_ADDI , 2'b00, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0}; // 000000100011
                `OP_ANDI:  `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_ANDI , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};//*
                `OP_XORI:  `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_XORI , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};//*
                `OP_SLTIU: `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_SLTIU , 2'b00, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};//*
                `OP_SLTI:  `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_SLTI , 2'b00, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};//*
                `OP_ORI:   `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_ORI  , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LUI:   `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_LUI  , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LB:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b001, 1'b1, `ALUOP_LW   , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LBU:   `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b010, 1'b1, `ALUOP_LW   , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LH:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b011, 1'b1, `ALUOP_LW   , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LHU:   `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b100, 1'b1, `ALUOP_LW   , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_LW:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b101, 1'b1, `ALUOP_LW   , 2'b00, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_SB:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_SW   , 2'b01, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_SH:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_SW   , 2'b10, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_SW:    `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_SW   , 2'b11, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                
                //Branch
                `OP_BEQ:   `SIGNAL = {2'b00, 1'b0, `BEQ, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_BNE:   `SIGNAL = {2'b00, 1'b0, `BNE, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_BGTZ:  `SIGNAL = {2'b00, 1'b0, `BGTZ, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_BLEZ:  `SIGNAL = {2'b00, 1'b0, `BLEZ, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                `OP_Branch_ELSE: begin
                    case (rt)
                        `rt_BGEZ:    `SIGNAL = {2'b00, 1'b0, `BGEZ, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                        `rt_BLTZ:    `SIGNAL = {2'b00, 1'b0, `BLTZ, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b0, 1'b1, 1'b0, 1'b0,`EXC_NOT,1'b0};
                        `rt_BGEZAL:  `SIGNAL = {2'b10, 1'b0, `BGEZAL, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0,`EXC_NOT,1'b0};
                        `rt_BLTZAL:  `SIGNAL = {2'b10, 1'b0, `BLTZAL, 3'b000, 1'b0, `ALUOP_Branch  , 2'b00, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0,`EXC_NOT,1'b0};
                    endcase
                end
                `OP_J:     `SIGNAL = {2'b00, 1'b1, `NOT_Branch, 3'b000, 1'b0, `ALUOP_J    , 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                // ADD by zjz
                `OP_JAL:   `SIGNAL = {2'b10, 1'b1, `NOT_Branch, 3'b000, 1'b0, `ALUOP_J    , 2'b00, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0,`EXC_NOT,1'b0}; // ALUOP is same as J
                `OP_CP0:begin
                    case (rs)
                        `rs_MF: 
                        begin
                            `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                            $display("The instruction is MFC0");
                            
                        end
                        `rs_MT:
                        begin 
                            `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b0};
                            $display("The instruction is MTC0");

                        end
                    endcase
                    
                    case(Funct)
                        `FUNCT_ERET:
                        begin
                            `SIGNAL = {2'b00, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_0, 2'b00, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0,`EXC_NOT,1'b1};
                            $display("The instruction is ERET");
                        end
                endcase
                end
                default:begin
                    `SIGNAL = {2'b01, 1'b0, `NOT_Branch, 3'b000, 1'b0, `ALUOP_R, 2'b00, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0,`EXC_UNDEFINE,1'b0};//##
                end
            endcase
        // $display("%b",`SIGNAL);
    end

endmodule //ctrl