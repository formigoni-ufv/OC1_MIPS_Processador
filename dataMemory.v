module dataMemory (
  address,
  writeData,
  memWrite,
  memRead,
  readData
);

  input             memWrite;
  input             memRead;
  input      [31:0] address;
  input      [31:0] writeData;
  output reg [31:0] readData;

  reg [31:0] memory[0:300];

  initial begin
  memory[ 0] = 0;
  memory[ 4] = 0;
  memory[ 8] = 0;
  memory[12] = 0;
  memory[16] = 0;
  memory[20] = 0;
  memory[24] = 0;
  memory[28] = 0;

  memory[32] = 0;
  memory[36] = 0;
  memory[40] = 0;
  memory[44] = 0;
  memory[48] = 0;
  memory[52] = 0;
  memory[56] = 0;
  memory[60] = 0;

  memory[64] = 0;
  memory[68] = 0;
  memory[72] = 0;
  memory[76] = 0;
  memory[80] = 0;
  memory[84] = 0;
  memory[88] = 0;
  memory[92] = 0;
  end

  always @ (address, writeData, memRead, memWrite) begin
    case (memWrite)
      0: begin
          case (memRead)
            0: ;
            1: readData <= memory[address];
          endcase
        end
      1: begin
        case (memRead)
          0: memory[address] <= writeData;
          1: ;
        endcase
        end
    endcase
  end



endmodule // dataMemory
