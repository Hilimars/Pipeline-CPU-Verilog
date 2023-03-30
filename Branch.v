`include "./Para.v"
module Branch (
  input clk,
  input [3:0] Branch,
  input [25:0] Immediate,
  input [31:0] Rs,
  input [31:0] Rt,
  output reg Flag_Branch

);
  initial
  begin
    Flag_Branch     = 0;
  end
  // always @(negedge clk) begin
  always @(*) begin
    case(Branch)
      `BEQ     :  Flag_Branch    <= (Rs == Rt) ? 1 : 0 ;
      `BNE     :  Flag_Branch    <= (Rs == Rt) ? 0 : 1 ;
      `BGTZ    :  Flag_Branch    <= ($signed(Rs) > 0) ? 1 : 0;
      `BLEZ    :  Flag_Branch    <= ($signed(Rs) < 0 || Rs == 0) ? 1 : 0;
      `BGEZ    :  Flag_Branch    <= ($signed(Rs) > 0 || Rs == 0) ? 1 : 0;
      `BLTZ    :  Flag_Branch    <= ($signed(Rs) < 0) ? 1 : 0;
      `BGEZAL  :  Flag_Branch    <= ($signed(Rs) > 0 || Rs == 0) ? 1 : 0;
      `BLTZAL  :  Flag_Branch    <= ($signed(Rs) < 0) ? 1 : 0;
      `NOT_Branch:Flag_Branch    <= 0;
    endcase
  end
endmodule //Branch