module register_file(input wire clk,
                    input wire [4:0] regs,//instruction
                    input wire [4:0] regt,//instruction
                    input wire [4:0] regd,//instruction
                    input wire regWrite,//semnal ce indica scrierea in registrul destinatie
                    input wire [31:0] dataWrite,//rezultat
                    output reg [31:0] reg1,//continut regs
                    output reg [31:0] reg2//continut regt
                    );//front pozitiv, scriere la front positiv regWrite
reg [31:0] [31:0] registerMemory;

always @(posedge clk) begin 
    if(regs <= 5'b11111 && regt <= 5'b11111)begin 
        reg1 <= registerMemory[regs];
        reg2 <= registerMemory[regt];
    end else begin 
        reg1 <= 32'b0;
        reg2 <= 32'b0;
    end
    if(regd <= 5'b11111 && regWrite == 1'b1) begin
        registerMemory[regd]<=dataWrite;
    end
end
endmodule