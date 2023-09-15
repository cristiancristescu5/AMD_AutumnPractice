module alu_controller(
  						input wire [1:0] ALUOp,
                        input wire [31:0] instruction,
                        output reg [5:0] selection);
always @(*)begin 
  case (ALUOp) 
    2'b10: begin //r-type
      selection <= instruction[5:0];
    end
    2'b00: begin //imm
      selection <= instruction[31:26];
    end
    2'b01:begin //beq
      selection <= instruction[31:26];
    end
    2'bxx:begin //jump
      selection<= 6'hx; 
     end 
  endcase
end
    
endmodule

