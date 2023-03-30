`include "./Para.v"

// reset or update pc
module pc(
    input [31:0] NPC,
    input        Clock,
    input        Reset,
    // input        PC_Sub_4_Ctrl,
    input        PC_Sub_4_Data,
    // input        Flag_Branch,
    input        Jump,   
    input [25:0] Immediate,
    // input        JR,
    // input [31:0] RegfileOut1,

    output reg [31:0] PC
);
    reg        [31: 0]  Pre_PC;

    always @(posedge Reset) begin
        PC <= `INIT_ADDR;
    end

    always @(posedge Clock) begin
        //if(Reset)
        //    PC <= `INIT_ADDR;
        // else if(Beq && !(PC_Sub_4_Ctrl || PC_Sub_4_Data))
        //     PC <= (BEQ_immed<<2) + NPC;
        // else if(!(PC_Sub_4_Ctrl || PC_Sub_4_Data))
        //$display("111go! pc = %h, at time: %t, NPC: %h, reset: %b", PC, $time, NPC, Reset);
        if(!PC_Sub_4_Data)begin
            PC <= NPC;
        end
        
    end
/*
    always @(Flag_Branch) begin
        if(Flag_Branch && !PC_Sub_4_Ctrl)        
            PC <= {{16{Immediate[15]}},Immediate[15:0], 2'b00};
    end
*/
    always @(Jump) begin
        if(Jump)
        PC <= {PC[31:28], Immediate, 2'b00};
    end

    // JR or JALR: PC <- GPR[rs]
    //always @(JR) begin
    //    if(JR)
    //        PC = RegfileOut1;
    //end
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