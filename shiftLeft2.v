module shiftLeft2 (
  a,
  out
);
  input      [31:0] a;
  output reg [31:0] out;

  always @ (a) begin
    out = (a << 2);
  end

endmodule // shiftLeft2
