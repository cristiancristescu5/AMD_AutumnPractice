module memory #(parameter SIZE = 32)(input wire [31:0] address,
                                    input wire [31:0] data,
                                    input wire clk,
                                    input wire memW,
                                    input wire memR,
                                    input wire reset,
                                    output wire [31:0] readData);
reg [31 : 0] memory [0 : SIZE-1];
reg [31:0] index;
 
  assign readData = (memR && !memW) ? memory[address] : 32'bz;

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
      if(memW && !memR) begin 
        memory[address] <= data;
        $display("la adresa: %d, salvez: %d", address, data);
      end
    end
 end
endmodule
