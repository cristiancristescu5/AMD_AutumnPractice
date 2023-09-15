module alu(input wire [31:0] op1,
            input wire [31:0] op2,
            input wire [5:0] selection,
            output wire zero,
            output reg [31:0] result);
    
    always @(*)begin
      case(selection)
            6'b100000:begin 
                 result <= op1 + op2;
                  end//add
            6'b100010:begin
                 result <= op1 - op2;
                  end//sub
            6'b100100:begin
                 result <= op1 & op2;
                  end//and
            6'b100101:begin
                 result <= op1 | op2;                 
                  end//or
            6'b100111:begin 
                result <= ~(op1 | op2);
                 end//nor
            6'b101010:begin //slt
                if(op1 < op2) begin 
                    result <=32'b1;
                end else begin 
                    result <=32'b0;
                end
             end
            6'b100110:begin
                 result <= op1 ^ op2;
                  end//xor
            6'b001000:begin 
                result <= op1 + op2;
                 end//addi
            6'b001100:begin
                 result <= op1 & op2;
                  end//andi
            6'b100011:begin 
                result <= op1 + op2;
                 end//lw
            6'b101011:begin
                 result <= op1 + op2;
                  end//sw
            6'b000100: begin 
              if(op1 == op2)begin 
                result <= 32'b0;
              end else begin 
                result <= 32'b01;
              end
                 end// beq (0 sau 1)
            default: begin 
              result <= op1 + op2;
             end
         endcase 
    end
  assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
endmodule