module arithmeticlogicunit(
	input[31:0] A, B,						//Inputs
	input[3:0] OP,							//Operation selector
	output reg[31:0] OUT,				//Result of the operation
	output wire zero						//Checks if the operation result is 0
	);

	assign zero = (OUT == 0);		//If the result of the op is 0, the flag is set to 1

	always @ (A, B, OP) begin
		case (OP)
			0: OUT = A & B;
			1: OUT = A | B;
			2: OUT = A + B;
			6: OUT = A - B;
			7: OUT = (A < B);
			default: ;
		endcase
	end
endmodule
