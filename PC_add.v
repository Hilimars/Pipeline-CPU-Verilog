// IF中的Add模块
module PC_add (
    input [31:0] PC,

    output reg [31:0] PC_add_4
);

    always @(PC) begin
        PC_add_4 <= PC + 4;
    end
endmodule //PC_add