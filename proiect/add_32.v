module addFull(input wire [31:0] a, 
                input wire [31:0] b,
                output reg [31:0] sum);
    always @(*) begin 
        sum <= a + b;
    end
endmodule