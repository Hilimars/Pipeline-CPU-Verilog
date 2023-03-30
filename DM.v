`include "./Para.v"

module dm (
    input [31:0] AluRes,
    input [31:0] InputData,
    input [1:0]  MemWrite,
    input [2:0]  MemRead,
    input        Clock,

    output reg [31:0] DmOutData
);
    reg [31:0] tmp; 
    reg [31:0] DM [`SIZE_DATA:0];
    initial 
    begin
        $readmemh(`PATH_DATA, DM, 0, `SIZE_DATA);
    end

    always @(negedge Clock) begin   // write InputData to DM   【DEBUG】不能写posedge，是不是产生冒险冲突会呀 啊啊啊啊 
        // if(MemWrite && AluRes)

        // sb
        if(MemWrite == 2'b01 && AluRes !== 32'bx)
            begin
                DM[AluRes[11:2]][7:0] = InputData[7:0];
                $display("dm:%d<=%h", AluRes, InputData[7:0]);
            end

        // sh
        if(MemWrite == 2'b10 && AluRes !== 32'bx)
            begin
                DM[AluRes[11:2]][15:0] = InputData[15:0];
                $display("dm:%d<=%h", AluRes, InputData[15:0]);
            end

        // sw
        if(MemWrite == 2'b11 && AluRes !== 32'bx)
            begin
                DM[AluRes[11:2]] = InputData;
                $display("dm:%d<=%h", AluRes, InputData);
            end
    end
    
    always @(*) begin               // Read DM write to DmOutData
        tmp = DM[AluRes[11:2]];
        // lb
        if(MemRead == 3'b001)
            DmOutData = {{24{tmp[7]}}, tmp[7:0]};
        // lbu
        if(MemRead == 3'b010)
            DmOutData = {{24'b0}, tmp[7:0]};
        // lh    
        if(MemRead == 3'b011)
            DmOutData = {{16{tmp[15]}}, tmp[15:0]};
        // lhu    
        if(MemRead == 3'b100)
            DmOutData = {{16'b0}, tmp[15:0]};
        // lw    
        if(MemRead == 3'b101)
            DmOutData = tmp;
    end

endmodule //dm