module maincontrolunit(
	input wire[5:0] op,
	output reg regDst,
	output reg ALUSrc,
	output reg memtoReg,
	output reg regWrite,
	output reg memRead,
	output reg memWrite,
	output reg branch,
	output reg ALUOp1,
	output reg ALUOp0
);

always @ (op) begin
	case(op)
		0: begin
				regDst	<=	1;
				ALUSrc	<= 0;
				memtoReg	<= 0;
				regWrite	<= 1;
				memRead	<= 0;
				memWrite	<= 0;
				branch	<= 0;
				ALUOp1	<= 1;
				ALUOp0	<= 0;
			end
		35:begin
				regDst	<=	0;
				ALUSrc	<= 1;
				memtoReg	<= 1;
				regWrite	<= 1;
				memRead	<= 1;
				memWrite	<= 0;
				branch	<= 0;
				ALUOp1	<= 0;
				ALUOp0	<= 0;
			end
		43:begin
				regDst	<=	0;
				ALUSrc	<= 1;
				memtoReg	<= 0;
				regWrite	<= 0;
				memRead	<= 0;
				memWrite	<= 1;
				branch	<= 0;
				ALUOp1	<= 0;
				ALUOp0	<= 0;
			end
		4:begin
				regDst	<=	0;
				ALUSrc	<= 0;
				memtoReg	<= 0;
				regWrite	<= 0;
				memRead	<= 0;
				memWrite	<= 0;
				branch	<= 1;
				ALUOp1	<= 0;
				ALUOp0	<= 1;
			end
	endcase
end

endmodule
