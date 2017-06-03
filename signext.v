module signext(
	input wire[15:0] i0,
	output reg[31:0] out
	);

	always @ (i0) begin
		case(i0[15])
			0: begin
					out = 16'b0000000000000000;
					out = i0;
				end
			1: begin
					out[31:16] = 16'b1111111111111111;
					out[15:0] = i0;
				end
		endcase
	end
endmodule
