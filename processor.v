`include "programcounter.v"
`include "instructionmemory.v"
`include "multiplexor.v"
`include "registerfile.v"
`include "signext.v"
`include "arithmeticlogicunit.v"
`include "alu_control.v"
`include "sll.v"
`include "datamemory.v"

module processor ();
	reg clk;
	//PC VARS
	wire [31:0] pcIn;
	wire[31:0] pcOut;
	//ALU(PC + 4) VARS
	wire[31:0] aluPCPlus4Out;
	//INSMEM VARS
	wire[31:0] insMemOut;
	//REG FILE MUX
	reg regDst = 0;		//TODO conectar o controle
	wire[4:0] regDstOut;
	//REG FILE VARS
	reg regWrite = 0;			//TODO conectar o controle
	wire[31:0] reg1content;
	wire[31:0] reg2content;
	wire[31:0] memtoRegOut;
	//SIGN EXT
	wire[31:0] extOut;
	//MAIN ALU MUX
	reg aluSrc = 0;		//TODO conectar o controle
	wire[31:0] aluSrcOut;
	//MAIN ALU CONTROL
	reg[1:0] ALUOp = 1;	//TODO conectar o controle
	wire[3:0] aluCtrlOut;
	//MAIN ALU
	wire zero;
	wire[31:0] aluMainOut;
	//SLL
	wire[31:0] sllOut;
	//BranchAlu
	wire[31:0] branchAluOut;
	//PCSrc MUX
	reg pcSrc;		//TODO conectar o controle
	wire[31:0] pcSrcOut;
	//DATA MEMORY
	wire[31:0] dataMemOut;
	//MEMtoREG MUX
	reg MemtoReg = 0;		//TODO conectar o controle

	programcounter pc(
		.clock(clk),
		.in(pcIn),
		.out(pcOut)
	);

	arithmeticlogicunit aluPCPlus4(
		.A(pcOut),
		.B(32'b1),
		.OP(4'b10),			//Fixed OP ALU value, only sum is performed
		.OUT(aluPCPlus4Out)
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

	shiftlogicalleft sll(
		.i0(extOut),
		.out(sllOut)
	);

	arithmeticlogicunit branchAlu(
		.A(aluPCPlus4Out),
		.B(sllOut),
		.OP(4'b10),
		.OUT(branchAluOut)
	);

	multiplexorPCSrc branchmux(
		.i0(aluPCPlus4Out),
		.i1(branchAluOut),
		.control(zero),	//TODO colocar saida de porta and aqui (zero && beq?)
		.out(pcIn)
	);

	datamemory datamem(
		.addr(aluMainOut),
		.writeData(reg2content),
		.memRead(1'b0),	//TODO conectar ao controle ambos memRead e memWrite
		.readData(dataMemOut)
	);

	multiplexorMemtoReg dataMemMux(
		.i0(aluMainOut),
		.i1(dataMemOut),
		.control(MemtoReg),
		.out(memtoRegOut)
	);

	initial begin
		$monitor("clk: %b\npcOut: %b\nPC+4: %b\nSllOut: %b\npcIn|muxOut: %b\ninsMemOut: %b\n", clk, pcOut, aluPCPlus4Out, sllOut, pcIn, insMemOut);
		// $monitor("reg1addr: %b\nreg2addr: %b\nreg1content: %b\nreg2content: %b\naluSrcOut: %b\n\n", insMemOut[25:21], insMemOut[20:16], reg1content, reg2content, aluSrcOut);
		// $monitor("MainAluOp: %b\nMainAluOut: %b\nZero: %b\n\n", aluCtrlOut, aluMainOut, zero);
		// $monitor("DataOut: %b\n", dataMemOut);
		// $monitor("reg2content: %b\nmemtoRegOut: %b\n", reg2content, memtoRegOut);
		// $monitor("clk: %b\nsignextOut: %b\nSLLOut: %b\nPCPlus4Out: %b\nBranchAluOut: %b\npcSrcOut: %b\n", clk, extOut, sllOut, aluPCPlus4Out, branchAluOut, pcIn);
	end

	//clk transition
	initial begin
	#200	clk = 0;
	#200	clk = 1;
	#200	clk = 0;
	#200	clk = 1;
	#200	clk = 0;
	// #200	clk = 1;
	// #200	clk = 0;
	end

endmodule
