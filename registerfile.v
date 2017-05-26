module registerfile(
	input wire clk,
	input wire[4:0] reg1addr,
	input wire[4:0] reg2addr,
	input wire[4:0] regWaddr,
	input wire[31:0] data,
	input wire regWflag,
	output reg[31:0] reg1content,
	output reg[31:0] reg2content
	);

	reg[5:0] i;								//5 bits to go copy the bits 0 to 31
	reg[31:0] registers[0:31];			//Registers

	initial begin
		registers[0] = 0;
		registers[16] = 4;
		registers[17] = 32;
		registers[18] = 10;
		registers[19] = 2;
	end

	///////////OUTPUT ASSIGNMENT////////////
	always @ (reg1addr) begin
		for(i=0; i<32; i++)begin
			reg1content[i] = registers[reg1addr][i];
		end
	end

	always @ (reg2addr) begin
		for(i=0; i<32; i++)begin
			reg2content[i] = registers[reg2addr][i];
		end
	end

	////////////DATA WRITE//////////////////
	always@(posedge clk) begin
		if(regWflag == 1) begin
			for(i=0; i<32; i++)begin
				registers[regWaddr][i] = data[i];
			end
		end
	end
endmodule
