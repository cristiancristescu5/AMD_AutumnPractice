module alu_controller(input wire ALUOp,
                        input wire [31:0] instruction,
                        output reg [2:0] selection);
always @(*)begin 
    if(ALUO)begin 
        case(instruction[5:0])
        6'b100000 : selection <= 3'b010; // add
        6'b100010 : selection <= 3'b110; // sub
        6'b100100 : selection <= 3'b110; // and
        6'b100101 : selection <= 3'b111; // or
        6'b100110 : selection <= 3'b000; // xor
        6'b101010 : selection <= 3'b001; // slt(set less than)
        6'b000000 : selection <= 3'b010; // sll
        6'b000010 : selection <= 3'b011; // srl
        default: selection <= 3'b010; // add
        endcase
    end
end
    
endmodule
