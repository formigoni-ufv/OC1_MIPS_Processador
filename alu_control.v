module alu_control(
	input [1:0] ALUOp,
	input [5:0] funcCode,
	output reg [3:0] aluCtrlOut
	);

	always @ (ALUOp, funcCode) begin
		case(ALUOp)
			0: aluCtrlOut = 4'b0010;
			1: aluCtrlOut = 4'b0110;
			2: case (funcCode)
						36: aluCtrlOut = 0; // AND
						37: aluCtrlOut = 1; // OR
						32: aluCtrlOut = 2; // ADD
						42: aluCtrlOut = 7; //SLT
						34: aluCtrlOut = 6; // SUB
				endcase
		endcase
  end
endmodule
