module instruction_memory#(parameter SIZE = 128)(input wire [31:0] readAdress,
                            input wire clk,
                            input wire reset,
                            output reg [31:0] instruction);
reg [31:0] instructions [0 : SIZE-1];
reg [31:0] index;
initial begin 
    for(index = 0 ; index < SIZE ; index = index + 1)begin 
            instructions[index]<=32'b0;
        end
    index <= 32'b0;
end
always @(posedge clk)begin 
    if(reset)begin 
        for( index = 0 ; index < SIZE ; index = index+1) begin
                instructions[index] = 0;
        end
        index <= 32'b0;
    end else begin 
        if(readAdress/(32'h4) <= SIZE-1)begin 
            instruction <= instructions[readAdress/32'h4];
        end else begin 
            instruction <= instructions[32'b0];
        end
    end
end
endmodule