module shiftlogicalleft(
	input wire[31:0] i0,
	output reg[31:0] out
);

	always @ (i0) begin
		out = i0 << 2;
	end

endmodule
