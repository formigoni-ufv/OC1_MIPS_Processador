module alu_control(ALUop, FuncCode, ALUctl);
  input [1:0] ALUop;
  input [5:0] FuncCode;
  output reg [3:0] ALUctl;
  
  reg [3:0] temp;

  always @ (ALUop) begin
    case (FuncCode)
        32: temp <= 2; // ADD
        34: temp <= 6; // SUB
        36: temp <= 0; // AND
        37: temp <= 1; // OR
        39: temp <= 12; //NOR
        42: temp <= 7; //SLT
      default: temp <= 15;
    endcase
  end

always @ (*) begin
  case (ALUop)
    0: ALUctl = 2; // ADD
    1: ALUctl = 6; //SUB
    2: ALUctl = temp;
    default: ;
  endcase
end

endmodule
