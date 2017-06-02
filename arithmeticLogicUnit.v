module arithmeticLogicUnit (
  a,
  b,
  op,
  out,
  zero
);

  input      [31:0] a;
  input      [31:0] b;
  input      [ 3:0] op;
  output reg [31:0] out;
  output reg zero;

  always @ (a, b, op) begin
    case (op)
      0: begin //AND
           out <= (a & b);
        end
      1: begin //OR
           out <= (a | b);
        end
      2: begin //ADD
           out <= (a + b);
        end
      6: begin //SUB
           out <= (a - b);
           case (out)
             0: zero = 1;
             default: zero = 0;
           endcase
        end
      7: begin //SLT
           out <= (a << b);
        end
    endcase
  end



endmodule // arithmeticLogicUnit
