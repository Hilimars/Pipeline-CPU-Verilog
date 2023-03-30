`include "./Para.v"
module npc (
    input [31:0] PC_add_4,
    // input        Branch, 
    // input        Zero,  
    // input        PC_Sub_4,
    input        PC_Sub_4_Ctrl,
    input        PC_Sub_4_Data, // Data Bubble
    input        Flag_Branch,
    input        Jump,   
    input [25:0] Immediate,
    input        JR,
    input        ERET,
    input [31:0] Branch_Mux_Rs,

    output reg [31:0] NPC
);
    reg        [31: 0]  PC;
    reg        [31: 0]  EPC;

    initial
    begin
        EPC = `EPC_ADDR;
    end
    always @(*) begin
        PC  = PC_add_4 - 4;
        if(ERET)begin
            NPC = EPC;
        end
        else if(JR)begin
            NPC = Branch_Mux_Rs;
        end  
        else if(Jump)
            begin
                NPC = {PC[31:28], Immediate, 2'b00} + 4;
                //NPC = {PC[31:28], {Immediate << 2}};
            end
        else if(Flag_Branch && !PC_Sub_4_Ctrl)
            begin
                NPC = ({{16{Immediate[15]}},Immediate[15:0]} << 2) + PC;
            end
        else
            begin
                if(PC_Sub_4_Ctrl || PC_Sub_4_Data)  // insert one bubble
                    NPC = PC_add_4 - 4;
                else
                    NPC = PC_add_4;
            end
    end

    // always @(Beq) begin
    //     if(Beq && !PC_Sub_4_Ctrl)        
    //     NPC <= Branch_PC + 4;
    // end
endmodule //npc