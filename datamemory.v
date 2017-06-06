module datamemory(
	input wire[31:0] addr,
	input wire[31:0] writeData,
	input wire memRead,
	input wire memWrite,
	output reg[31:0] readData
);

	reg[512:0] memory, bitaddr;
	reg[32:0] i;

	initial begin
		memory[63:32] = 32'b100100100;
		memory[95:64] = 32'b100101;
	end

	always @ (addr, writeData) begin
		bitaddr = addr*8;
		if(memRead)begin
			for(i=0; i<32; i=i+1)begin
				readData[i] = memory[bitaddr+i];
			end
		end
		if(memWrite)begin
			for(i=0; i<32; i=i+1)begin
				memory[bitaddr+i] = writeData[i];
			end
		end
	end

endmodule
