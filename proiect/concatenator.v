module concat(input wire [27:0] shiftaddr,
                input wire [31:0] addr,
                output wire [31:0] finalAddr);
    assign finalAddr = {addr[31:28], shiftaddr};
endmodule