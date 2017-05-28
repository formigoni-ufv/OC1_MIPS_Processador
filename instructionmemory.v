module instructionmemory (
	input wire[31:0] addr,
	output reg[31:0] instruction
	);

	reg[31:0] memory[0:2];	//TODO aumentar memoria

	///////////MEMORIA DE INSTRUCOES//////////////////////
	initial begin
		memory[0] <= 32'b00000001000010011000000000100000;	//add $s0 $t0 $t1
		memory[1] <= 32'b00000001000010011000000000100010;	//sub $s0 $t0 $t1
		memory[2] <= 32'b00000001000010011000000000100100;	//and $s0 $t0 $t1
	end

	always @ (addr) begin
		instruction <= memory[addr];
	end
endmodule
