module add(input wire [31:0] address,
            output wire [31:0] newAddress);
	assign newAddress = address + 3'b100;
endmodule