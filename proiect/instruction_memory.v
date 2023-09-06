module instruction_memory(input wire [31:0] readAdress,
                            input wire clk,
                            input wire reset,
                            output reg [31:0] instruction);
reg [31:0] [127:0] instructions;
always @(readAdress)begin 
    if(readAdress/(32'h4) <= 127)begin 
        instruction <= instructions[readAdress/4];
    end
end
endmodule