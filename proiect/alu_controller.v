module alu_controller(input wire ALUOp,
                        input wire AluSrc,
                        input wire [31:0] instruction,
                        output reg [5:0] selection);
always @(*)begin 
    if(ALUOp && AluSrc ==1'b0)begin 
        selection <= instruction[5:0];
    end else begin 
        selection <= instruction[31:26];
    end
end
    
endmodule
