module program_counter(input wire clk,
                        input wire reset,
                        input wire [31:0] nextInstruction,
                        output reg [31:0] currentInstruction);
  initial begin 
    currentInstruction <= 32'b0;
end
always @(posedge clk, posedge reset)begin
    if(reset)begin 
        currentInstruction <= 32'b0;
    end else begin 
	  currentInstruction <=nextInstruction;
    end
end
endmodule