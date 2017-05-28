`include "programcounter.v"
`include "instructionmemory.v"
`include "arithmeticlogicunit.v"

module processor ();
	reg clk;
	//PC VARS
	reg [31:0] pcIn = 0;
	wire[31:0] pcOut;
	//IM VARS
	reg[31:0] imemAddr;
	wire[31:0] imemOut;
	//ALU VARS
	reg[31:0] aluI1, aluI2;
	reg[3:0] OP = 2;				//Fixed OP ALU value, only sum is performed
	wire[31:0] aluOut;
	wire zero;

	programcounter pc(
		.clock(clk),
		.in(pcIn),
		.out(pcOut)
	);

	arithmeticlogicunit alu(
		.A(aluI1),
		.B(aluI2),
		.OP(OP),
		.OUT(aluOut),
		.zero(zero)
	);

	instructionmemory imem(
		.addr(pcOut),
		.instruction(imemOut)
	);

	initial begin
		$monitor("clk: %b\naluOut: %b\npcIn: %b\npcOut: %b\nimemOut: %b\n", clk, aluOut, pcIn, pcOut, imemOut);
	end

	initial begin
	#5	clk = 1;
	#5	clk = 0;
	#5	clk = 1;
	#5	clk = 0;
	#5	clk = 1;
	#5	clk = 0;
	end

	always @ (negedge clk) begin
	#1	aluI1 <= pcOut;
		aluI2 <= 1;
	#1	pcIn <= aluOut;
	end
endmodule //
