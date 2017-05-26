`include "registerfile.v"

module testbench();
	reg clk;
	reg[4:0] reg1addr, reg2addr, regWaddr;
	reg[31:0] data;
	reg regWflag;
	wire[31:0] reg1content, reg2content;

	registerfile rfile(
		.clk(clk),
		.reg1addr(reg1addr),
		.reg2addr(reg2addr),
		.regWaddr(regWaddr),
		.data(data),
		.regWflag(regWflag),
		.reg1content(reg1content),
		.reg2content(reg2content)
	);

	initial begin
		clk <= 0;
		reg1addr <= 17;
		reg2addr <= 19;
		$monitor("data1: %b data2: %b", reg1content, reg2content);
	end

endmodule
