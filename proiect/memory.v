module memory #(parameter SIZE = 32)(input wire [31:0] address,
                                    input wire [31:0] data,
                                    input wire clk,
                                    input wire memW,
                                    input wire reset,
                                    output reg [31:0] readData);
reg [SIZE-1 : 0] [31 : 0] memory;
reg [31:0] index;
always @(posedge clk)begin 
    if(reset)begin 
        for(index = 0 ; index < SIZE ; index = index + 1)begin 
            memory[index]<=32'b0;
        end
        index <= 32'b0;
    end else begin
        if(address <= SIZE-1) begin 
            case (memW)
                1'b1:begin 
                    memory[address] <=data;
                end
                1'b0:begin 
                    readData <= memory[address];
                end
            endcase
        end
    end
end


endmodule