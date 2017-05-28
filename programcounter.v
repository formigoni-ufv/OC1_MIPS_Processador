module programcounter(
	input wire clock,
	input wire[31:0] in,
	output reg[31:0] out
);

	always @ (posedge clock) begin
		out = in;
	end

endmodule
