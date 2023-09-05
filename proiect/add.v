module add(input wire [31:0] address,
            output reg [31:0] newAddress);

always @(address) begin 
    newAddress <= address + 32'h4;
end
endmodule