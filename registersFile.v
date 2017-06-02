module registersFile(
  clock,
  readRegister1,
  readRegister2,
  writeRegister,
  writeData,
  readData1,
  readData2,
  regWrite
);
  input wire clock;
  input      regWrite;
  input      [ 4:0] readRegister1;
  input      [ 4:0] readRegister2;
  input      [ 4:0] writeRegister;
  input      [31:0] writeData;
  output reg [31:0] readData1;
  output reg [31:0] readData2;

  reg[31:0] registers[0:31];			//Registers

	initial begin
		registers[0]  = 0; //$ZERO
		registers[1]  = 0; //?
		registers[2]  = 0; // 2-3 $V0 e $V1
		registers[3]  = 0;
		registers[4]  = 0;//4-7 $a0
		registers[5]  = 0;
		registers[6]  = 0;
		registers[7]  = 0;
		registers[8]  = 0; //8-15 $t0
		registers[9]  = 0;
		registers[10] = 0;
		registers[11] = 0;
		registers[12] = 0;
		registers[13] = 0;
		registers[14] = 0;
		registers[15] = 0;
		registers[16] = 0;//16-23 $s0
		registers[17] = 20;
		registers[18] = 2;
		registers[19] = 5;
		registers[20] = 30;
		registers[21] = 6;
		registers[22] = 21;
		registers[23] = 21;
		registers[24] = 0;//24-25 $t8 e $t9
		registers[25] = 0;
		registers[26] = 0;
		registers[27] = 0;
		registers[28] = 0;
		registers[29] = 0;
		registers[30] = 0;
		registers[31] = 0;
	end

  always @ (readRegister1, readRegister2) begin
      readData1 <= registers[readRegister1];
      readData2 <= registers[readRegister2];
  end
  always @ (posedge clock, regWrite) begin
      case (regWrite)
        0: begin
          end
        1: begin
             registers[writeRegister] = writeData;
          end
      endcase
  end

endmodule // registers
