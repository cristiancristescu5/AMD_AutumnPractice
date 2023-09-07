module program_counter(input wire clk,
                        input wire reset,
                        input wire [31:0] nextInstruction,
                        output reg [31:0] currentInstruction);
reg [31:0] instruction;
initial begin 
    instruction <= 32'b0;
    currentInstruction <= 32'b0;
end
always @(posedge clk, nextInstruction)begin
    if(reset)begin 
        instruction <= 32'b0;
        currentInstruction <= 32'b0;
    end else begin 
        instruction <= nextInstruction;
        currentInstruction <= instruction;
    end
end
endmodule