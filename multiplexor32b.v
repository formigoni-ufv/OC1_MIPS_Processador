module multiplexor32b(
  a,
  b,
  control,
  out
);

  input      control;
  input      [31:0] a;
  input      [31:0] b;
  output reg [31:0] out;

  always @ (a, b, control) begin
    case (control)
      0: begin
           out = a;
         end
      1: begin
           out = b;
        end
    endcase
  end

endmodule // multiplexor32b
