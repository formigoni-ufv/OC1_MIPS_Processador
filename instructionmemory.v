module instructionmemory (
	input wire[31:0] addr,
	output reg[31:0] instruction
	);

	reg[31:0] memory[0:31];	//TODO aumentar memoria

	///////////MEMORIA DE INSTRUCOES//////////////////////
	initial begin
		// memory[0] <= 32'b00000001000010011000000000100000;		//add $s0 $t0 $t1
		// memory[1] <= 32'b00000001001010101000000000100010;		//sub $s0 $t1 $t2
		// memory[2] <= 32'b00000001000010011000000000100100;		//and $s0 $t0 $t1
		// memory[0] <= 32'b10001101000010010000000000000001;
		memory[0] <= 32'b00010001000010010000000000000010;
		memory[2] <= 32'b00010001000010010000000000000010;
		memory[9] <= 32'b00010001000010011111111111111110;

	end

	always @ (addr) begin
		instruction <= memory[addr];
	end
endmodule
