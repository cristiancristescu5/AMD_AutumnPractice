module left_shift(input wire [31:0] addr,
                    output wire [31:0] newAddr);
    assign newAddr = addr << 2'b10; 
endmodule