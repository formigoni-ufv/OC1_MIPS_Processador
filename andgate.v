module andgate(
	input wire i0,
	input wire i1,
	output reg out
);

	always @ (i0, i1) begin
		out = i0 & i1;
	end

endmodule
