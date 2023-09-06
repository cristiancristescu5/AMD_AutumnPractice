module register_file(input wire clk,
                    input wire [4:0] regs,
                    input wire [4:0] regt,
                    input wire [4:0] regd,
                    input wire regWrite,
                    input wire [31:0] dataWrite,
                    output reg [31:0] reg1,
                    output reg [31:0] reg2
                    );
reg [31:0] [31:0] registerMemory;

always @(posedge clk, regs, regt, regd, posedge regWrite) begin 
    if(regs <= 5'b11111 && regt <= 5'b11111)begin 
        reg1 <= registerMemory[regs];
        reg2 <= registerMemory[regt];
    end
end
always @(posedge clk , posedge regWrite, dataWrite, regd)begin 
    if(regd <= 5'b11111) begin
        registerMemory[regd]<=dataWrite;
    end
end

endmodule