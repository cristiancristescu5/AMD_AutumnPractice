module instruction_memory#(parameter SIZE = 128)(input wire [31:0] readAdress,
                            input wire clk,
                            input wire reset,
                            output reg [31:0] instruction);
  reg [31:0] instructions [0 : SIZE-1] ;
reg [31:0] index;
initial begin 
    for(index = 0 ; index < SIZE ; index = index + 1)begin 
      instructions[index]<=32'b0;
        end
    index <= 32'b0;
  instructions[0] <= 32'h00011020;
  instructions[1] <= 32'h00642820;
  instructions[2] <= 32'hae010000;
  instructions[3] <= 32'h8e040000;
  	
end
  always @(posedge clk, posedge reset)begin 
    if(reset)begin 
        for( index = 0 ; index < SIZE ; index = index+1) begin
          instructions[index] = 32'b0;
        end
        index <= 32'b0;
    end else begin 
      if(readAdress/(32'h4) <= SIZE-1 && instructions[readAdress/32'h4] != 32'b0)begin 
            instruction <= instructions[readAdress/32'h4];
        end else begin 
            instruction <=32'bx;
        end
    end
end
endmodule