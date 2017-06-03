// `include "multiplexor.v"
//
// module testbench();
// 	reg[31:0] i1, i2;
// 	reg control;
// 	wire[31:0] out;
//
// 	multiplexor mult(
// 		.i1(i1),
// 		.i2(i2),
// 		.control(control),
// 		.out(out)
// 	);
//
// 	initial begin
// 		i1 <= 4'b1010;
// 		i2 <= 4'b1001;
// 		control <= 0;
// 	end
//
// 	always @ (i1, i2, control) begin
// 		$monitor("%b", out);
// 	end
// endmodule

//
// `include "registerfile.v"
//
// module testbench();
// 	reg clk;
// 	reg[4:0] reg1addr, reg2addr, regWaddr;
// 	reg[31:0] data;
// 	reg regWflag;
// 	wire[31:0] reg1content, reg2content;
//
// 	registerfile rfile(
// 		.clk(clk),
// 		.reg1addr(reg1addr),
// 		.reg2addr(reg2addr),
// 		.regWaddr(regWaddr),
// 		.data(data),
// 		.regWflag(regWflag),
// 		.reg1content(reg1content),
// 		.reg2content(reg2content)
// 	);
//
// 	initial begin
// 		clk <= 1;
// 		regWflag <= 1;
// 		regWaddr <= 9;
// 		reg1addr <= 9;
// 		reg2addr <= 19;
// 		data <= 4'b1100;
// 		$monitor("regWritten: %b", reg1content);
// 	end
//
// endmodule

// `include "programcounter.v"
//
// module testbench ();
// 	reg clk;
// 	reg[31:0] in;
// 	wire[31:0] out;
//
// 	programcounter pc(
// 		.clock(clk),
// 		.in(in),
// 		.out(out)
// 	);
//
// 	initial begin
// 		clk = 0;
// 		in = 4'b1011;
// 		$monitor("%b", out);
// 	end
// endmodule

// `include "instructionmemory.v"
//
// module testbench ();
// 	reg[31:0] addr;
// 	wire[31:0] instruction;
//
// 	instructionmemory imem(
// 		.addr(addr),
// 		.instruction(instruction)
// 	);
//
// 	initial begin
// 		#5 addr = 2'b00;
// 		#5 addr = 2'b01;
// 		#5 addr = 2'b10;
// 	end
//
// 	always @ (addr) begin
// 		$monitor("%b", instruction);
// 	end
// endmodule

// `include "signext.v"
//
// module testbench();
// 	reg[15:0] i0;
// 	wire[31:0] out;
//
// 	signext ext(
// 		.i0(i0),
// 		.out(out)
// 	);
//
// 	initial begin
// 		$monitor("i0: %b\nout: %b\n\n", i0, out);
// 	end
//
// 	initial begin
// 		#5	i0 = 16'b1000000000000000;
// 		$display("i0[15]: %b", i0[15]);
// 		#5	i0 = 16'b0100000000000000;
// 		$display("i0[15]: %b", i0[15]);
// 	end
// endmodule

`include "andgate.v"

module testbench();
	reg i0, i1;
	wire out;

	andgate gate(
		.i0(i0),
		.i1(i1),
		.out(out)
	);

	initial begin
			i0 <= 1;
			i1 <= 1;
			$monitor("Out: %b\n", out);
	end


endmodule
