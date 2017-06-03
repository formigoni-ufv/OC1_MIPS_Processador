module multiplexorRegDst(
	input wire[4:0] i0, i1,
	input wire control,
	output reg[4:0] out
	);

	always @ (i0, i1, control) begin
		case(control)
			0: out <= i0;
			1: out <= i1;
		endcase
	end
endmodule

module multiplexorALUSrc(
	input wire[31:0] i0, i1,
	input wire control,
	output reg[31:0] out
	);

	always @ (i0, i1, control) begin
		case(control)
			0: out <= i0;
			1: out <= i1;
		endcase
	end
endmodule


module multiplexorMemtoReg(
	input wire[31:0] i0, i1,
	input wire control,
	output reg[31:0] out
	);

	always @ (i0, i1, control) begin
		case(control)
			0: out <= i0;
			1: out <= i1;
		endcase
	end
endmodule

module multiplexorPCSrc(
	input wire[31:0] i0, i1,
	input wire control,
	output reg[31:0] out
	);

	always @ (i0, i1, control) begin
		case(control)
			0: out <= i0;
			1: out <= i1;
		endcase
	end
endmodule
