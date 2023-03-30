`include "./Para.v"

module dm (
    input [31:0] AluRes,
    input [31:0] InputData,
    input        MemWrite,
    input        MemRead,
    input        Clock,

    output reg [31:0] DmOutData
);
    reg [31:0] DM [`SIZE_DATA:0];
    initial 
    begin
        $readmemh(`PATH_DATA, DM, 0, `SIZE_DATA);
    end

    always @(negedge Clock) begin   // write InputData to DM   【DEBUG】不能写posedge，是不是产生冒险冲突会呀 啊啊啊啊 
        // if(MemWrite && AluRes)
        if(MemWrite && AluRes !== 32'bx)
            begin
                DM[AluRes[11:2]] = InputData;
                $display("dm:%d<=%h", AluRes, InputData);
            end
    end
    
    always @(*) begin               // Read DM write to DmOutData
        if(MemRead)
            DmOutData = DM[AluRes[11:2]];
    end

endmodule //dm