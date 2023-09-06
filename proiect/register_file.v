module register_file(input wire clk,
                    input wire [31:0] regs,//instruction
                    input wire [31:0] regt,//instruction
                    input wire [31:0] regd,//instruction
                    input wire regWrite,//semnal ce indica scrierea in registrul destinatie
                    input wire [31:0] dataWrite,//rezultat
                    output reg [31:0] reg1,//continut regs
                    output reg [31:0] reg2//continut regd
                    );//front pozitiv, scriere la front positiv regWrite
reg [31:0] [31:0] registerMemory;

always @(posedge clk) begin 
    if(regs[25:21] <= 5'b11111 && regt[20:16] <= 5'b11111)begin 
        reg1 <= registerMemory[regs[25:21]];
        reg2 <= registerMemory[regt[20:16]];
    end else begin 
        reg1 <= 32'b0;
        reg2 <= 32'b0;
    end
    if(regd[15:11] <= 5'b11111 && regWrite == 1'b1) begin
        registerMemory[regd[15:11]]<=dataWrite;
    end
end
endmodule