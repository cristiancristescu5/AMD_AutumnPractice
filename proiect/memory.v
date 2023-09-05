module memory #(parameter WIDTH = 32)(input wire [31:0] address,
                                    input wire [31:0] data,
                                    input wire clk,
                                    input wire memW,
                                    output reg [31:0] readData);
reg [WIDTH-1 : 0] [31 : 0] memory;

always @(posedge clk)begin 
    if(address <= WIDTH) begin 
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


endmodule