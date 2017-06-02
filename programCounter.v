module programCounter (
  clock,
  in,
  out
);

  input wire clock;
  input wire [31:0] in;
  output reg [31:0] out;

  always @ (posedge clock, in) begin
    out = in;
  end

endmodule // programCounter
