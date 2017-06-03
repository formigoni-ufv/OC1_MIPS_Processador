`include "programcounter.v"
`include "instructionmemory.v"
`include "multiplexor.v"
`include "registerfile.v"
`include "signext.v"
`include "arithmeticlogicunit.v"
`include "alu_control.v"
`include "datamemory.v"

module processor ();
	reg clk;
	//PC VARS
	reg [31:0] pcIn = 0;
	wire[31:0] pcOut;
	//ALU(PC + 4) VARS
	wire[31:0] aluOut;
	//INSMEM VARS
	wire[31:0] insMemOut;
	//REG FILE MUX
	reg regDst = 0;		//TODO conectar o controle
	wire[4:0] regDstOut;
	//REG FILE VARS
	reg regWrite = 1;			//TODO conectar o controle
	wire[31:0] reg1content;
	wire[31:0] reg2content;
	wire[31:0] memtoRegOut;
	//SIGN EXT
	wire[31:0] extOut;
	//MAIN ALU MUX
	reg aluSrc = 1;		//TODO conectar o controle
	wire[31:0] aluSrcOut;
	//MAIN ALU CONTROL
	reg[1:0] ALUOp = 0;	//TODO conectar o controle
	wire[3:0] aluCtrlOut;
	//MAIN ALU
	wire zero;
	wire[31:0] aluMainOut;
	//DATA MEMORY
	wire[31:0] dataMemOut;
	//MEMtoREG MUX
	reg MemtoReg = 1;		//TODO conectar o controle

	programcounter pc(
		.clock(clk),
		.in(pcIn),
		.out(pcOut)
	);

	arithmeticlogicunit aluPCPlus4(
		.A(pcOut),
		.B(32'b1),
		.OP(4'b10),			//Fixed OP ALU value, only sum is performed
		.OUT(aluOut)
	);

	instructionmemory insmem(
		.addr(pcOut),
		.instruction(insMemOut)
	);

	multiplexorRegDst regfilemux(
		.i0(insMemOut[20:16]),
		.i1(insMemOut[15:11]),
		.control(regDst),
		.out(regDstOut)
	);

	signext ext(
		.i0(insMemOut[15:0]),
		.out(extOut)
	);

	registerfile regfile(
		.clk(clk),
		.reg1addr(insMemOut[25:21]),
		.reg2addr(insMemOut[20:16]),
		.regWaddr(regDstOut),
		.data(memtoRegOut),
		.regWrite(regWrite),
		.reg1content(reg1content),
		.reg2content(reg2content)
	);

	multiplexorALUSrc alumux(
		.i0(reg2content),
		.i1(extOut),
		.control(aluSrc),
		.out(aluSrcOut)
	);

	alu_control aluControl(
		.ALUOp(ALUOp),
		.funcCode(insMemOut[5:0]),
		.aluCtrlOut(aluCtrlOut)
	);

	arithmeticlogicunit mainAlu(
		.A(reg1content),
		.B(aluSrcOut),
		.OP(aluCtrlOut),
		.OUT(aluMainOut),
		.zero(zero)
	);

	datamemory datamem(
		.addr(aluMainOut),
		.writeData(reg2content),
		.memRead(1'b1),
		.readData(dataMemOut)
	);

	multiplexorMemtoReg dataMemMux(
		.i0(aluMainOut),
		.i1(dataMemOut),
		.control(MemtoReg),
		.out(memtoRegOut)
	);

	initial begin
		// $monitor("clk: %b\naluOut: %b\npcIn: %b\npcOut: %b\ninsMemOut: %b\n", clk, aluOut, pcIn, pcOut, insMemOut);
		// $monitor("reg1addr: %b\nreg2addr: %b\nreg1content: %b\nreg2content: %b\naluSrcOut: %b\n\n", insMemOut[25:21], insMemOut[20:16], reg1content, reg2content, aluSrcOut);
		// $monitor("MainAluOp: %b\nMainAluOut: %b\n\n", aluCtrlOut, aluMainOut);
		// $monitor("DataOut: %b\n", dataMemOut);
		$monitor("reg2content: %b\nmemtoRegOut: %b\n", reg2content, memtoRegOut);
	end

	//clk transition
	initial begin
	#200	clk = 1;
	#200	clk = 0;
	// #200	clk = 1;
	// #200	clk = 0;
	// #200	clk = 1;
	// #200	clk = 0;
	end

	//PC = PC + 4;
	always @ (negedge clk) begin
		pcIn <= aluOut;
	end

endmodule
