module datamemory(
	input wire clk,
	input wire[31:0] addr,
	input wire[31:0] writeData,
	input wire memRead,
	input wire memWrite,
	output reg[31:0] readData
);

	reg[31:0] memory[0:63];

	always @ (addr, writeData, memRead)begin
		if(memRead) readData <= memory[addr];
	end

	always @ (posedge clk) begin
		if(memWrite) memory[addr] <= writeData;
	end

endmodule
