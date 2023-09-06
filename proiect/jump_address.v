module jump_address(input wire [32:0] address,
                    output wire [28:0] extended);
    assign extended = {address[25:0], 2'b00};
endmodule