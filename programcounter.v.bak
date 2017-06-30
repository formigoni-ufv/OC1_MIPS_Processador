module programcounter(
	input wire clock,
	input wire[31:0] in,
	output reg[31:0] out
);
	reg kept;

	////////INITIAL VALUE/////////
	initial begin
		#1	kept = 0;
	end

	always @ (kept) begin
	out = kept;
	end
	//////////////////////////////

	always @ (posedge clock) begin
		out = in;
	end

endmodule
