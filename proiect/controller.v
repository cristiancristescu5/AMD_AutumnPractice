module controller(input wire [31:0] instruction,
                   output reg RegDst,
                   input wire reset, 
                   output reg Jump,
                   output reg Branch,
                   output reg MemRead,
                   output reg MemtToReg,
                  output reg[1:0] AluOp,
                   output reg MemWrite,
                   output reg AluSrc,
                   output reg regWrite);
reg [5:0] op;
always @(*)begin
    if(reset)begin 
        RegDst <= 0;
        Jump <=0; 
        Branch <=0;
        MemRead <= 0;
        MemtToReg <= 0;
        AluOp <=2'b00;
        MemWrite<=0;
        AluSrc <=0;
        regWrite <=0;
    end else begin
        op <= instruction [31:26];  
    case(op)
        6'b000000: begin //add, sub, and, or, xor, nor (R-type)
            RegDst <= 1;
            Jump <=0;
            Branch <=0;
            MemRead <= 0;
            MemtToReg <= 0;
            AluOp <=2'b10;
            MemWrite<=0;
            AluSrc <=0;
            regWrite <=1;
        end
        6'b100011:begin //lw
            RegDst <=0;
            Jump<=0;
            Branch <=0;
            MemRead <= 1;
            MemtToReg <= 1;
            AluOp <=2'b00;
            AluSrc <=1;
            regWrite<=1;
          	MemWrite<=0;
        end
        6'b101011:begin  //sw
            RegDst <=0;
            Jump <=0;
            Branch <=0;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=2'b00;
            AluSrc <=1;
            regWrite <=0;
          	MemWrite <=1;
        end 
        6'b001000: begin //addi
            RegDst <= 0;
            Jump <= 0;
            Branch <=0;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=2'b00;
            AluSrc <=1;
            MemWrite <=0;
            regWrite <=1;

        end
        6'b001100: begin//andi 
            RegDst <= 0;
            AluSrc <= 1;
            AluOp <=2'b00;
            Jump <=0;
            Branch <= 0;
            regWrite <= 1;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end 
        6'b001101: begin//ori
            RegDst <= 0;
            AluSrc <= 1;
            AluOp <=2'b00;
            Jump <=0;
            Branch <= 0;
            regWrite <= 1;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end
        6'b000100: begin//beq 
            RegDst <= 0;
            Jump <= 0;
            Branch <=1;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=2'b01;
            AluSrc <=0;
            MemWrite <=0;
            regWrite <=0;
        end
        6'b000010: begin //jump 
            RegDst <= 0;
            AluSrc <= 0;
            AluOp <=2'bxx;
            Jump <=1;
            Branch <= 0;
            regWrite <= 0;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end
    endcase
    end
end
endmodule