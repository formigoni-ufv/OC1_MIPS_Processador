module multiplexor(
	input wire[31:0] i1, i2,
	input wire control,
	output reg[31:0] out
	);

	always @ (i1, i2, control) begin
		case(control)
			0: out <= i1;
			1: out <= i2;
		endcase
	end
endmodule
