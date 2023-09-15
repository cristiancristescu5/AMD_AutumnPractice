module jump_address(input wire [31:0] address,
                    output wire [27:0] extended);
    assign extended = {address[25:0], 2'b00};
endmodule