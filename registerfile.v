module registerfile(
	input wire clk,
	input wire[4:0] reg1addr,
	input wire[4:0] reg2addr,
	input wire[4:0] regWaddr,
	input wire[31:0] data,
	input wire regWrite,
	output reg[31:0] reg1content,
	output reg[31:0] reg2content
	);

	reg update;								//5 bits to go copy the bits 0 to 31
	reg[31:0] registers[0:31];			//Registers

	initial begin
		registers[0] = 0;
		registers[8] = 6;
		registers[9] = 10;
		registers[10] = 6;
		registers[16] = 4;
		registers[17] = 32;
		registers[18] = 10;
		registers[19] = 2;
	end

	///////////OUTPUT ASSIGNMENT////////////
	always @ (reg1addr) begin
			reg1content <= registers[reg1addr];
	end

	always @ (reg2addr, update) begin
		reg2content <= registers[reg2addr];
		update <= 0;
	end

	////////////DATA WRITE//////////////////
	always@(negedge clk) begin
		if(regWrite == 1) begin
			registers[regWaddr] = data;
			update = 1;
		end
	end
endmodule
