module sign_extend(input wire [31:0] instr,
                    output wire [31:0] extension);
    assign extension = {{16{instr[15]}}, instr[15:0]};
endmodule