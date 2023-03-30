`include "./Para.v"
module register_file (
    input [4:0]  rs,
    input [4:0]  rt,
    input [4:0]  rd,
    input [31:0] InputData,
    input        RegWrite,
    input        Clock,
    input        Reset,

    output [31:0] rsData,
    output [31:0] rtData
);

    reg [31:0] Registers [31:0];
    
    // initial begin
    //     for(i = 0; i < 32; i=i+1)
    //         Registers[i] <= 32'h0000_0000;
    // end
    integer i;
    initial begin
        // $display("i am here %d",rd);
        // $display("i am here %d",InputData);
        // $monitor("register_file value %b at the time %t.", RegWrite, $time);
    end
    always @(negedge Clock or posedge Reset) begin
        if(RegWrite && rd != 5'b00000) // 这里加了rd != 5'b00000，debug的时候想到了，但是就感觉小离谱  应该是和&&rd等价
            begin
                Registers[rd] <= InputData;
                $display("reg:$%d<=%h", rd, InputData);
            end
        else if(Reset)
            for(i = 0; i < 32; i=i+1)
                Registers[i] <= 32'h0000_0000;
    end

    assign rsData = (rs==0) ? 0 : Registers[rs];
    assign rtData = (rt==0) ? 0 : Registers[rt];

    initial begin
    //   $monitor("InputData change to value %d at the time %t.", InputData, $time);
    end

endmodule //register_file