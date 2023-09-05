module program_counter(input wire clk,
                        input wire reset,
                        input wire [31:0] nextInstruction,
                        output reg [31:0] currentInstruction);
reg [31:0] instruction;
always @(posedge clk, nextInstruction)begin
    instruction <= nextInstruction;
    currentInstruction <= instruction;
end
always @(posedge reset)begin 
    instruction <= 32'b0;
    currentInstruction <= 32'b0;
end
endmodule