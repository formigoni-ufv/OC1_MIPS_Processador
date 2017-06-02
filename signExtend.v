module signExtend(
  a,
  out
);

  input      [15:0] a;
  output reg [31:0] out;

  always @ (a) begin
    out[31:0] <= {{8{a[15]}}, a[15:0]};
  end


endmodule // signExtend
