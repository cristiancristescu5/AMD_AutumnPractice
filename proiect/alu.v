module alu(input wire [31:0] op1,
            input wire [31:0] op2,
            input wire [5:0] selection,
            output reg zero,
            output reg [31:0] result);
    
    always @(*)begin
         

      case(selection)
            6'b100000:begin 
                 result <= op1 + op2;
                 zero <= result == 32'b0;
                 end//add
            6'b100010:begin
                 result <= op1 - op2;
                 zero <= result == 32'b0;
                 end//sub
            6'b100100:begin
                 result <= op1 & op2;
                 zero <= result == 32'b0;
                 end//and
            6'b100101:begin
                 result <= op1 | op2;                 
                 zero <= result == 32'b0;
                 end//or
            6'b100111:begin 
                result <= ~(op1 | op2);
                zero <= result == 32'b0;
                end//nor
            6'b101010:begin //slt
                if(op1 < op2) begin 
                    result <=1;
                end else begin 
                    result <=0;
                end
                zero <= result == 32'b0;
            end
            6'b100110:begin
                 result <= op1 ^ op2;
                 zero <= result == 32'b0;
                 end//xor
            6'b001000:begin 
                result <= op1 + op2;
                zero <= result == 32'b0;
                end//addi
            6'b001100:begin
                 result <= op1 & op2;
                 zero <= result == 32'b0;
                 end//andi
            6'b100011:begin 
                result <= op1 + op2;
                zero <= result == 32'b0;
                end//lw
            6'b101011:begin
                 result <= op1 + op2;
                 zero <= result == 32'b0;
                 end//sw
            6'b000100: begin 
                result <= op1 == op2; 
                zero <= ~(op1 == op2);
                end// beq (0 sau 1)
            default: begin 
              result <= op1 + op2;
              zero <= result == 32'b0;
            end
         endcase 
    end
endmodule