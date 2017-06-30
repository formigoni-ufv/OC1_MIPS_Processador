//Ruan Evangelista Formigoni - 2661
//Adriano Martins – 2640

module processor (
	input wire clock,
	input wire realclock,
	input wire reset, sw9, sw8, sw7, sw6, sw5, sw4, sw3, sw2,
	output reg led0, led1, led2, led3, led4, led5, led6, led7, led8, led9,
	output wire[6:0] DISPLAY0, DISPLAY1, DISPLAY2, DISPLAY3, DISPLAY4, DISPLAY5
	);
	
	reg[31:0] i;
	//clk
	reg clk;
	//Main Control Unit VARS
	wire branch;
	//PC VARS
	wire [31:0] pcIn;	//PCSrcMUX
	wire[31:0] pcOut;
	//ALU(PC + 4) VARS
	wire[31:0] aluPCPlus4Out;
	//INSMEM VARS
	wire[31:0] insMemOut;
	//REG FILE MUX
	wire regDst;
	wire[4:0] regDstOut;
	//REG FILE VARS
	wire regWrite;
	wire[31:0] reg1content;
	wire[31:0] reg2content;
	wire[31:0] memtoRegOut;
	//SIGN EXT
	wire[31:0] extOut;
	//MAIN ALU MUX
	wire aluSrc;
	wire[31:0] aluSrcOut;
	//MAIN ALU CONTROL
	wire[1:0] ALUOp;
	wire[3:0] aluCtrlOut;
	//MAIN ALU
	wire zero;
	wire[31:0] aluMainOut;
	//SLL
	wire[31:0] sllOut;
	//BranchAlu
	wire[31:0] branchAluOut;
	//AND
	wire andGateOut;
	//DATA MEMORY
	wire memRead, memWrite;
	wire[31:0] dataMemOut;
	//MEMtoREG MUX
	wire MemtoReg;


	/********FPGA I/O OUTPUT*******/
	reg [3:0] displaysIn[5:0];
	
	 decoder display0(
	 	.in(displaysIn[0]),
	 	.out(DISPLAY0)
	 );
	
	 decoder display1(
	 	.in(displaysIn[1]),
	 	.out(DISPLAY1)
	 );
	
	 decoder display2(
	 	.in(displaysIn[2]),
	 	.out(DISPLAY2)
	 );
	
	 decoder display3(
	 	.in(displaysIn[3]),
	 	.out(DISPLAY3)
	 );
	
	
	 decoder display4(
	 	.in(displaysIn[4]),
	 	.out(DISPLAY4)
	 );
	
	
	 decoder display5(
	 	.in(displaysIn[5]),
	 	.out(DISPLAY5)
	 );
	 
	 //CLOCK
	always@(posedge realclock)begin
		
		if(sw9 == 0)begin
			clk = clock;
		end
		
		else if(sw9 == 1)begin
			i = i+1;
			if(i == 50000000)begin
				clk = 1;
			end
			else if(i == 100000000)begin
				clk = 0;
				i=0;
			end
		end
	
	end
	
	//LEDS
	always@(sw9, sw8, sw8, sw7, sw6, sw5, sw4, sw3, sw2, reset, clock)begin
		if(sw9)   led9 = 1; else led9 = 0;
		if(sw8)   led8 = 1; else led8 = 0;
		if(sw7)   led7 = 1; else led7 = 0;
		if(sw6)   led6 = 1; else led6 = 0;
		if(sw5)   led5 = 1; else led5 = 0;
		if(sw4)   led4 = 1; else led4 = 0;
		if(sw3)   led3 = 1; else led3 = 0;
		if(sw2)   led2 = 1; else led2 = 0;
		if(reset) led1 = 1; else led1 = 0;
		if(clock) led0 = 1; else led0 = 0;
	end
	
	//SWITCHES
	always@(sw8, sw7, sw6, sw5, sw4, sw3, sw2, pcOut, aluPCPlus4Out, pcIn, aluMainOut)begin
		if(sw8 == 1)begin
			displaysIn[0] <= pcOut[3:0];
			displaysIn[1] <= pcOut[7:4];
			displaysIn[2] <= pcOut[11:8];
			displaysIn[3] <= pcOut[15:12];
			displaysIn[4] <= pcOut[19:16];
			displaysIn[5] <= pcOut[23:20];
		end
		else if(sw7 == 1) begin
			displaysIn[0] <= aluPCPlus4Out[3:0];
			displaysIn[1] <= aluPCPlus4Out[7:4];
			displaysIn[2] <= aluPCPlus4Out[11:8];
			displaysIn[3] <= aluPCPlus4Out[15:12];
			displaysIn[4] <= aluPCPlus4Out[19:16];
			displaysIn[5] <= aluPCPlus4Out[23:20];
		end
		else if(sw6 == 1) begin
			displaysIn[0] <= pcIn[3:0];
			displaysIn[1] <= pcIn[7:4];
			displaysIn[2] <= pcIn[11:8];
			displaysIn[3] <= pcIn[15:12];
			displaysIn[4] <= pcIn[19:16];
			displaysIn[5] <= pcIn[23:20];
		end
		else if(sw5 == 1)begin
			displaysIn[0] <= aluSrcOut[3:0];
			displaysIn[1] <= aluSrcOut[7:4];
			displaysIn[2] <= aluSrcOut[11:8];
			displaysIn[3] <= aluSrcOut[15:12];
			displaysIn[4] <= aluSrcOut[19:16];
			displaysIn[5] <= aluSrcOut[23:20];
		end
		else if(sw4 == 1)begin
			displaysIn[0] <= reg1content[3:0];
			displaysIn[1] <= reg1content[7:4];
			displaysIn[2] <= reg1content[11:8];
			displaysIn[3] <= reg1content[15:12];
			displaysIn[4] <= reg1content[19:16];
			displaysIn[5] <= reg1content[23:20];
		end		
		else if(sw3 == 1)begin
			displaysIn[0] <= aluMainOut[3:0];
			displaysIn[1] <= aluMainOut[7:4];
			displaysIn[2] <= aluMainOut[11:8];
			displaysIn[3] <= aluMainOut[15:12];
			displaysIn[4] <= aluMainOut[19:16];
			displaysIn[5] <= aluMainOut[23:20];
		end

	end
	/****************************/


	//Modules Instantiation
	programcounter pc(
		.clock(clk),
		.in(pcIn),
		.out(pcOut),
		.reset(reset)
		
	);

	arithmeticlogicunit aluPCPlus4(
		.A(pcOut),
		.B(32'b100),
		.OP(4'b10),
		.OUT(aluPCPlus4Out)
	);

	instructionmemory insmem(
		.addr(pcOut),
		.instruction(insMemOut)
	);

	maincontrolunit controlUnit(
		.op(insMemOut[31:26]),
		.regDst(regDst),
		.ALUSrc(aluSrc),
		.memtoReg(MemtoReg),
		.regWrite(regWrite),
		.memRead(memRead),
		.memWrite(memWrite),
		.branch(branch),
		.ALUOp1(ALUOp[1]),
		.ALUOp0(ALUOp[0])
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
		.control(andGateOut),
		.out(pcIn)
	);

	andgate gate(
		.i0(branch),
		.i1(zero),
		.out(andGateOut)
	);

	datamemory datamem(
		.clk(clk),
		.addr(aluMainOut),
		.writeData(reg2content),
		.memRead(memRead),
		.memWrite(memWrite),
		.readData(dataMemOut)
	);

	multiplexorMemtoReg dataMemMux(
		.i0(aluMainOut),
		.i1(dataMemOut),
		.control(MemtoReg),
		.out(memtoRegOut)
	);

endmodule
