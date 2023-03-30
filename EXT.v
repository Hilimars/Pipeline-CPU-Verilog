`include "./Para.v"

module ext (
    input [15:0] InputNum,
    input        ExtOp,     // 1 is signed extend, 0 is unsigned extend

    output reg [31:0] OutputNum
);

    always @(*) begin
        if(ExtOp)
            OutputNum = {{16{InputNum[15]}}, InputNum[15:0]};
        else
            OutputNum = {16'h0000, InputNum[15:0]};
    end

endmodule //ext