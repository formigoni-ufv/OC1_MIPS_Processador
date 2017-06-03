module datamemory(
	input wire[31:0] addr,
	input wire[31:0] writeData,
	input wire memRead,
	input wire memWrite,
	output reg[31:0] readData
);

	reg[31:0] memory[0:31]; //TODO Aumentar tamanho da memoria

	initial begin
		memory[0] = 32'b100;
		memory[1] = 32'b101;
		memory[7] = 32'b10101;
	end

	always @ (addr, writeData) begin
		if(memRead) readData = memory[addr];
		if(memWrite) memory[addr] = writeData;
	end

endmodule
