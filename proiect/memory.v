module memory #(parameter SIZE = 32)(input wire [31:0] address,
                                    input wire [31:0] data,
                                    input wire clk,
                                    input wire memW,
                                    input wire memR,
                                    input wire reset,
                                    output reg [31:0] readData);
reg [SIZE-1 : 0] [31 : 0] memory;
reg [31:0] index;
initial begin 
    for(index = 0 ; index < SIZE ; index = index + 1)begin 
            memory[index]<=32'b0;
        end
    index <= 32'b0;
end
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
                    if(memR == 1'b0)begin 
                        memory[address] <=data;
                    end
                end
                1'b0:begin
                    if(memR == 1'b1) begin 
                        readData <= memory[address];
                    end
                end
            endcase
        end else begin 
            if(memW == 1'b0 && memR == 1'b1)begin 
                readData <= 32'hx;
            end
        end
    end
end
endmodule