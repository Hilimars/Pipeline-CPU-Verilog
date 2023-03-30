module npc (
    input [31:0] PC_add_4,
    // input        Branch, 
    // input        Zero,  
    // input        PC_Sub_4,
    input        PC_Sub_4_Ctrl,
    input        PC_Sub_4_Data, // Data Bubble
    input        Beq,
    input        Jump,   
    input [31:0] BEQ_immed, // extend Immediate used in BEQ
    input [25:0] Jump_immed,  // Jump instruction address
    input [31:0] Branch_PC,

    output reg [31:0] NPC
);
    reg        [31: 0]  PC;

    always @(*) begin
        if(Jump)
            begin
                PC  = PC_add_4 - 4;
                NPC = {PC[31:28], Jump_immed, 2'b00} + 4;
            end
        else if(Beq && !PC_Sub_4_Ctrl)
            begin
                NPC = Branch_PC + 4;
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