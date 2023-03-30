`include "./Para.v"
module Branch (
  input clk,
  input [5:0] Opcode,
  input [25:0] Immediate,
  input [31:0] Rs,
  input [31:0] Rt,

  output reg Flag_Beq,
  output reg [31:0] BEQ_imme_out,
  output reg Flag_Jump,
  output reg [25:0] Jump_imme_out
);
initial
begin
    Flag_Jump    = 0;
    Flag_Beq     = 0;
end
// always @(negedge clk) begin
always @(*) begin
  case(Opcode)
    `OP_J: 
    begin
      Flag_Jump     <= 1;
      Jump_imme_out <= Immediate;
    end
    `OP_BEQ:
    begin
      Flag_Beq     <= (Rs === Rt);
      BEQ_imme_out <= {{16{Immediate[15]}},Immediate[15:0]}; 
    end
    default:
    begin
      Jump_imme_out <= Immediate;
      BEQ_imme_out <= {{16{Immediate[15]}},Immediate[15:0]}; 
      Flag_Jump    <= 0;
      Flag_Beq     <= 0;
    end 
  endcase
end
endmodule //Branch