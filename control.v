module control (
  opCode,
  regDst,
  memRead,
  branch,
  memToReg,
  aluOp,
  memWrite,
  aluSrc,
  regWrite
);

  input      [5:0] opCode;
  output reg [1:0] aluOp;
  output reg regDst;
  output reg memRead;
  output reg branch;
  output reg memToReg;
  output reg memWrite;
  output reg aluSrc;
  output reg regWrite;


  always @ (opCode) begin
    case (opCode)
      0: begin //ADD, SEB, AND, OR, SLT
           regDst   = 1;
           memRead  = 0;
           branch   = 0;
           memToReg = 1;
           aluOp    = 2;
           memWrite = 0;
           aluSrc   = 0;
           regWrite = 1;
        end
      4: begin //BEQ
           regDst   = 0;
           memRead  = 0;
           branch   = 1;
           memToReg = 0;
           aluOp    = 1;
           memWrite = 0;
           aluSrc   = 0;
           regWrite = 0;
        end
      35: begin //LW
           regDst   = 0;
           memRead  = 1;
           branch   = 0;
           memToReg = 1;
           aluOp    = 0;
           memWrite = 0;
           aluSrc   = 1;
           regWrite = 0;
        end
      43: begin //SW
           regDst   = 0;
           memRead  = 0;
           branch   = 0;
           memToReg = 0;
           aluOp    = 0;
           memWrite = 1;
           aluSrc   = 1;
           regWrite = 0;
        end
    endcase
  end


endmodule // control
