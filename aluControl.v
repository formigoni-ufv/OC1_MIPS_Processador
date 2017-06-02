module aluControl (
  aluOp,
  funcCode,
  aluCtl
);

  input      [1:0] aluOp; //vem do controle
  input      [5:0] funcCode;
  output reg [3:0] aluCtl;

  always @ (aluOp, funcCode) begin
    case (aluOp)
      0: begin //LW ou SE
           aluCtl = 2; //ADD
         end
      1: begin //BEQ
           aluCtl = 6; //SUB
         end
      2: begin //TIPO R
            case (funcCode)
              32:begin //ADD
                   aluCtl = 2;
                 end
              34:begin //SUB
                   aluCtl = 6;
                 end
              36:begin //AND
                   aluCtl = 0;
                 end
              37:begin //OR
                   aluCtl = 1;
                 end
              42:begin //SLT
                   aluCtl = 7;
                 end
            endcase
         end
    endcase
  end



endmodule // alu_control
