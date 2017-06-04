module instructionmemory (
	input wire[31:0] addr,
	output reg[31:0] instruction
	);

	reg[31:0] memory[0:31];

	///////////MEMORIA DE INSTRUCOES//////////////////////
	initial begin
		memory[0] <= 32'b00000001000010011000000000100000;			//add $s0 $t0 $t1 16
		memory[1] <= 32'b00000010000010101000000000100010;			//sub $s0 $s0 $t2 12
		memory[2] <= 32'b00010001010010110000000000000001;			//beq $t2, $t3, 1
		memory[7] <= 32'b00000010000010101000000000100010;			//sub $s0 $s0 $t1 8
	end

	always @ (addr) begin
		instruction <= memory[addr];
	end
endmodule
