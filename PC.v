`include "./Para.v"

// reset or update pc
module pc(
    input [31:0] NPC,
    input        Clock,
    input        Reset,
    input        PC_Sub_4_Ctrl,
    input        PC_Sub_4_Data,
    input        Beq,
    input        Jump,   
    input [31:0] BEQ_immed, // extend Immediate used in BEQ
    input [25:0] Jump_immed,  // Jump instruction address
    input [31:0] Branch_PC,

    output reg [31:0] PC
);
    reg        [31: 0]  Pre_PC;

    always @(posedge Clock or posedge Reset) begin
        if(Reset)
            PC <= `INIT_ADDR;
        // else if(Beq && !(PC_Sub_4_Ctrl || PC_Sub_4_Data))
        //     PC <= (BEQ_immed<<2) + NPC;
        // else if(!(PC_Sub_4_Ctrl || PC_Sub_4_Data))
        else if(!PC_Sub_4_Data)                                     
            PC <= NPC;
    end
    always @(Beq) begin
        if(Beq && !PC_Sub_4_Ctrl)        
        PC <= Branch_PC;
    end
    always @(Jump) begin
        if(Jump)        
        PC <= {PC[31:28], Jump_immed, 2'b00};
    end
    // initial begin
    //     // $monitor("PC:%b, at time %t",PC, $time);
    // end

    // always @(PC_Sub_4_Ctrl or PC_Sub_4_Data) begin
    // // always @(negedge Clock) begin
    //     if(PC_Sub_4_Data)
    //     begin
    //         PC = PC - 4;
    //     end
    //     else if(PC_Sub_4_Ctrl)
    //     begin
    //         PC = PC - 4;
    //     end
    // end

    // // always @(negedge Clock) begin
    // always @(Beq) begin
    //     if(Beq && !(PC_Sub_4_Ctrl || PC_Sub_4_Data))
    //     begin
    //        PC = (BEQ_immed<<2) + PC + 4;
    //     end
    // end

    // always @(Jump) begin
    //     if(Jump)
    //     begin
    //         Pre_PC = PC - 4;
    //         PC = {Pre_PC[31:28], Jump_immed, 2'b00};
    //     end
    // end

endmodule //pc