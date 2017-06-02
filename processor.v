`include "adder.v"
`include "aluControl.v"
`include "arithmeticLogicUnit.v"
`include "control.v"
`include "dataMemory.v"
`include "doorAnd.v"
`include "instructionMemory.v"
`include "multiplexor5b.v"
`include "multiplexor32b.v"
`include "registersFile.v"
`include "programCounter.v"
`include "shiftLeft2.v"
`include "signExtend.v"

module processor ();

  reg clk;
	reg  [31:0] pcIn = 0;
	wire [31:0] pcOut;

	programCounter pc(
		.clock(clk),
		.in(pcIn),
		.out(pcOut)
	);

	reg  [31:0] addFix = 4;
	wire [31:0] add1Out;

	adder add1(
		.a(pcOut),
		.b(addFix),
		.out(add1Out)
	);

	wire [31:0] instruction;

	instructionMemory instMem(
		.address(pcOut),
		.instruction(instruction)
	);

	wire regDst;
	wire memRead;
	wire branch;
	wire memToReg;
	wire [1:0] aluOp;
	wire memWrite;
	wire aluSrc;
	wire regWrite;

	control control(
		.opCode(instruction[31:26]),
		.regDst(regDst),
		.memRead(memRead),
		.branch(branch),
		.memToReg(memToReg),
		.aluOp(aluOp),
		.memWrite(memWrite),
		.aluSrc(aluSrc),
		.regWrite(regWrite)
	);

	wire [4:0] writeRegister;

	multiplexor5b mux1(
		.a(instruction[20:16]),
		.b(instruction[15:11]),
		.control(regDst),
		.out(writeRegister)
	);

	wire [31:0] readData1Out;
	wire [31:0] readData2Out;

	registersFile register(
	.clock(clk),
	.readRegister1(instruction[25:21]),
	.readRegister2(instruction[20:16]),
	.writeRegister(writeRegister),
	.writeData(writeData),
	.readData1(readData1Out),
	.readData2(readData2Out),
	.regWrite(regWrite)
	);

	wire [31:0] extendOut;

	signExtend extand(
	.a(instruction[15:0]),
	.out(extendOut)
	);

	wire [31:0] AluInB;

	multiplexor32b mux2(
	.a(readData2Out),
	.b(extendOut),
	.control(aluSrc),
	.out(AluInB)
	);

	wire [3:0] op;

	aluControl aluClt(
	.aluOp(aluOp),
	.funcCode(instruction[5:0]),
	.aluCtl(op)
	);

	wire [31:0] aluResult;
	wire flagZero;

	arithmeticLogicUnit alu(
	.a(readData1Out),
	.b(AluInB),
	.op(op),
	.out(aluResult),
	.zero(flagZero)
	);

	wire [31:0] readDataOut;

	dataMemory dataMem(
	.address(aluResult),
	.writeData(readData2Out),
	.memWrite(memWrite),
	.memRead(memRead),
	.readData(readDataOut)
	);

	wire [31:0] writeData;


	multiplexor32b mux3(
	.a(readDataOut),
	.b(aluResult),
	.control(memToReg),
	.out(writeData)
  );

	wire [31:0] shift2Out;

	shiftLeft2 shift2(
	.a(extendOut),
	.out(shift2Out)
	);

	wire [31:0] add2Out;

	adder add2(
	.a(add1Out),
	.b(shift2Out),
	.out(add2Out)
	);

	wire andResult;

	doorAnd andDoor(
	.a(branch),
	.b(flagZero),
	.out(andResult)
	);

	wire [31:0] nextPC;

	multiplexor32b mux4(
	.a(add1Out),
	.b(add2Out),
	.control(andResult),
	.out(nextPC)
	);

initial begin
	$dumpfile("processor.vcd");
	$dumpvars;
end

initial begin

  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;
  #15	clk = 1;
  #15	clk = 0;

end


always @ (negedge clk ) begin
	#30 pcIn <= nextPC;
end
endmodule //
