module instructionmemory (
	input wire[31:0] addr,
	output reg[31:0] instruction
	);

	reg[31:0] memory[0:63];

	initial begin
		memory[0]  <= 32'b00000001000010011000000000100000;			//add $s0 $t0 $t1 // 10 + 6 = 16 HEX: 10
		memory[4]  <= 32'b00000010000010101000000000100010;			//sub $s0 $s0 $t2 // 16 - 4 = 12 HEX: C
		memory[8]  <= 32'b00010001010010110000000000000001;			//beq $t2 $t3 1   // Skips one word (4 bits)
		memory[16] <= 32'b00000010000010011000000000100010;			//sub $s0 $s0 $t1 // 12 - 6 = 6  HEX: 6
		memory[20] <= 32'b10101100000011000000000000000100;			//sw $t4 4($0) 	//Saves 77 on the data mem
		memory[24] <= 32'b10001100000011010000000000000100;			//lw $t5 4($0)	 	//Loads 77 from the data mem
		memory[28] <= 32'b00000001101100010110100000100000;			//add $t5 $t5 $s1 // 77 + 10 = 87 HEX: 57
		memory[32] <= 32'b00010001010010111111111111110111;			//beq $t2 $t3 -9 	//Goes back to the beginning
	end

	always @ (addr) begin
		instruction[31:0] = memory[addr];
	end
endmodule
