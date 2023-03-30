`include "./Para.v"

module im (
    input [31:0] PC,        // 32-bit PC

    output [31:0] OutInstr  // 32-bit instruction read from IM
);

    reg [31:0] IM[`SIZE_INSTR:0]; // all instructions restored in IM

    initial begin
        $readmemh(`PATH_INSTR, IM, 0, `SIZE_INSTR);
        // $display("%h",IM[0]);
        // $monitor("IM: PC is %h, 对应的指令为%h at time", PC, OutInstr, $time);
    end

    /*
        这里是书上RTL描述和实际实现中的差异：
        PC[11:2]这个操作，按照书本来的话，应该在最外层加个sign_ext(),符号位扩展后变成32-bit的符号数，
        但是吧，这里并没有做是因为我们在定义IM时候，读取的仅仅为1024条指令，因此IM这个数组大小只有10-bit，
        于是对应PC[11:2]便不用sgin_ext()了。---------【说错了，但是是记录下也】
        通俗讲，PC就是IM的下标（这里专业点叫地址）

        更正：上面说的其实是lb
        而MIPS里没有lb，lh只有lw；故这里的实现是没有问题的。
        lw就是32-bit的数据，不需要符号扩展
    */

    // assign相当于连线，一般是将一个变量的值 $不间断地$ 赋值给另一个变量
    assign OutInstr = IM[PC[11:2]];
    initial begin
    //   $monitor("OutInstr change to value %d at the time %t.", OutInstr, $time);
    end

endmodule //im