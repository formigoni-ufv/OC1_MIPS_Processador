module adder (
  a,
  b,
  out
);
  input      [31:0] a;
  input      [31:0] b;
  output reg [31:0] out;

  always @ ( a,b ) begin
    out = a + b;
  end

  endmodule // adder
