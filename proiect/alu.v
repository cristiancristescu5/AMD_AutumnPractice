module alu(input wire [31:0] op1,
            input wire [31:0] op2,
            input wire [5:0] selection,
            output reg zero,
            output reg [31:0] result);
    
    always @(*)begin
        // zero <= ((op1==32'b0) && (op2 == 32'b0));
        case(selection)
            6'b100000: result <= op1 + op2;//add
            6'b100010: result <= op1 - op2;//sub
            6'b100100: result <= op1 & op2;//and
            6'b100101: result <= op1 | op2;//or
            6'b100111: result <= ~(op1 | op2);//nor
            6'b101010:begin //slt
                if(op1 < op2) begin 
                    result <=1;
                end else begin 
                    result <=0;
                end
            end
            6'b100110: result <= op1 ^ op2;//xor

            default: result <= op1 + op2;//addi
        endcase 
    end
    assign zero = (result == 32'b0);
endmodule