module alu(input wire [31:0] op1,
            input wire [31:0] op2,
            input wire [2:0] selection,
            output reg zero,
            output reg [31:0] result);
    
    always @(*)begin
        zero <= ((op1==32'b0) && (op2 == 32'b0));
        case(selection)
            3'b100 : result <= op1 + op2;
            3'b101 : result <= op1 - op2;
            3'b110 : result <= op1 & op2;
            3'b111 : result <= op1 | op2;
            3'b000 : result <= op1 ^ op2;
            3'b001 : begin 
                if(op1 < op2)begin 
                    result <= 1;
                end else begin 
                    result <= 0;
                end 
            end
            // 3'b010: result <= op1 << op2;
            // 3'b011: result <= op1 >> op2;
            default: result <= op1 + op2;
        endcase 
    end

endmodule