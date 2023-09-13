// Code your design here
module register_file(input wire clk,
                    input wire [4:0] regs,//instruction
                    input wire [4:0] regt,//instruction
                    input wire [4:0] regd,//instruction
                    input wire regWrite,//semnal ce indica scrierea in registrul destinatie
                    input wire reset,
                    input wire [31:0] dataWrite,//rezultat
                    output wire [31:0] reg1,//continut regs
                    output wire [31:0] reg2//continut regt
                    );//front pozitiv, scriere la front positiv regWrite
  reg [31:0] registerMemory [0 : 31]; 
  integer index;
  initial begin
    for(index = 0 ; index <= 31 ; index = index + 1) begin 
      registerMemory[index] <= 32'b0;
    end
    registerMemory[0] <= 32'h100;
    registerMemory[1] <= 32'h200;
    registerMemory[3] <= 32'h594;
    registerMemory[4] <= 32'h410;
    registerMemory[8] <=32'd1;
  end
  always @(posedge clk, posedge reset) begin 
  	if(reset) begin 
      for(index = 0 ; index <= 31 ; index = index + 1)begin 
        registerMemory[index] <=32'b0;
      end
  	end else begin
    	if(regd <= 5'b11111 && regWrite) begin
        	registerMemory[regd]<=dataWrite;
           $display("data: %h ,%h", regd, dataWrite);
    	end
    end
    $display("la 4: %h", registerMemory[4]);
  end
    assign reg1 = (regs != 0) ? registerMemory[regs] : 32'b0;
    assign reg2 = (regt != 0) ? registerMemory[regt] : 32'b0;
endmodule