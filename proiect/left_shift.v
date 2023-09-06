module left_shift(input wire [31:0] addr,
                    output wire [31:0] newAddr);
    assign y = {addr[29:1], 2'b00};           
endmodule