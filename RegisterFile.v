`include "./Para.v"
module register_file (
    input [5:0]  Opcode,

    input [4:0]  rs,
    input [4:0]  rt,
    input [4:0]  rd,
    input [31:0] InputData,
    input        RegWrite,
    input        Clock,
    input        Reset,
    input        MEM_WB_IS_NOP,
    input overflow,//**
    input [31:0] OPC,//**
    input [4:0] EXCCODE,//#
    input [31:0]ins,//##

    output [31:0] rsData,
    output [31:0] rtData
);

    reg [31:0] Registers [31:0];
    reg [31:0] CP0 [31:0];//可以output出去暴露给外面

    // initial begin
    //     for(i = 0; i < 32; i=i+1)
    //         Registers[i] <= 32'h0000_0000;
    // end
    // 
    integer i;
    initial begin
        // $display("i am here %d",rd);
        // $display("i am here %d",InputData);
        // $monitor("register_file value %b at the time %t.", RegWrite, $time);
    end

    always @(posedge Reset) begin
        for (i = 0; i < 32; i = i + 1)
            Registers[i] = 0;
    end

    ///一直开着

    always @(negedge Clock) begin
        //#
        if(EXCCODE==5'b00000)begin
        // 如果不是NOP就存入
            if(RegWrite && rd != 5'b00000 && !MEM_WB_IS_NOP) // 这里加了rd != 5'b00000，debug的时候想到了，但是就感觉小离谱  应该是和&&rd等价
                begin
                    //Registers[rd] <= InputData;
                    //*
                    if(overflow && rd != 31)
                        $display("overflow:%h", OPC);
                    else begin
                        Registers[rd] <= InputData;
                        $display("reg:$%d<=%h", rd, InputData);
                    end
                        
                end
            //else if(Reset)
            //    for(i = 0; i < 32; i=i+1)
            //        Registers[i] <= 32'h0000_0000;
        end
        //break
        else if(EXCCODE==5'b00001&&(ins!=0))begin//不加ins会多输出
            $display("break:%h", OPC);
            
        end
        //syscall
        else if(EXCCODE==5'b00011&&(ins!=0))begin
            $display("syscall:%h", OPC);
        end
        //undefine
        else if(EXCCODE==5'b11111&&(ins!=0))begin
            $display("undefine:%h", OPC);
        end
    end

    assign rsData = (rs==0) ? 0 : Registers[rs];
    assign rtData = (rt==0) ? 0 : Registers[rt];
    always @(*) begin
        if(Opcode == `OP_CP0)
        begin
        case(rs)
                `rs_MF: Registers[rt] = CP0[rd];
                `rs_MT: CP0[rd] = Registers[rt];
        endcase
        end
    end
    initial begin
    //   $monitor("InputData change to value %d at the time %t.", InputData, $time);
    end

endmodule //register_file