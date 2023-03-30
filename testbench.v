`timescale 1ps/1ps
`include "./mips.v"

module Testbench();
    reg    clk ;
    reg    rst ;

    
    Mips mips(clk, rst);

    initial begin
    //   $monitor("Counter change to value %d at the time %t.", cnt, $time);
    end

    initial 
        begin
            clk <= 0 ;
            rst <= 1 ;
            #10 rst <= 0; 
            #20000 $finish;
        end
            
    integer cnt = 0;
    always@(*)
    begin
        #20 clk<=~clk;
        cnt = cnt + 1;
        
    end
        initial 
    begin
        // $monitor($time, "");
        $dumpfile("wave.vcd");
        $dumpvars;    
    end
    
    
endmodule