module instruction_memory#(parameter SIZE = 18)(input wire [31:0] readAdress,
                            input wire clk,
                            input wire reset,
                            output reg [31:0] instruction);
  reg [31:0] instructions [0 : SIZE-1] ;
reg [31:0] index;
initial begin 
//     for(index = 0 ; index < SIZE ; index = index + 1)begin 
//       instructions[index]<=32'b0;
//         end
//     index <= 32'b0;
//   instructions[0] <= 32'h00011020;
//   instructions[1] <= 32'h00642820;
//   instructions[2] <= 32'hae010000;
//   instructions[3] <= 32'h8e040000;
//   instructions[4] <= 32'h20310099;
//   instructions[5] <= 32'h08000008;
//   instructions[8] <= 32'h10010001;
//   instructions[10] <= 32'h00011020;
  $readmemh("instructions.dat", instructions);
end
  always @(*) begin 
      if(readAdress/(32'h4) <= SIZE-1 && instructions[readAdress/32'h4] != 32'b0)begin 
            instruction <= instructions[readAdress/32'h4];
        end else begin 
            instruction <=32'bx;
        end
  end
endmodule