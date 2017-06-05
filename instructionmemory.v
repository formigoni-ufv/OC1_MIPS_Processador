module instructionmemory (
	input wire[31:0] addr,
	output reg[31:0] instruction
	);

	reg[512:0] memory;
	reg[32:0] i;
	reg[512:0] bitaddr;
	///////////MEMORIA DE INSTRUCOES//////////////////////
	initial begin
		memory[31:0]  <= 32'b00000001000010011000000000100000;			//add $s0 $t0 $t1 16
		memory[63:32] <= 32'b00000010000010101000000000100010;			//sub $s0 $s0 $t2 12
		memory[95:64] <= 32'b00010001010010110000000000000001;			//beq $t2, $t3, 1
		memory[159:128] <= 32'b00000010000010101000000000100010;			//sub $s0 $s0 $t1 8
	end

	always @ (addr) begin
		#5 bitaddr = addr * 8;														//Transforma bytes em bits
		#5 for(i=0; i<32; i++)begin
				instruction[i] = memory[bitaddr+i];
			end
	end
endmodule
