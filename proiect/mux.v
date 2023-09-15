module mux #(parameter WIDTH = 32)(input wire [WIDTH-1:0] sel0,
                                    input wire [WIDTH-1:0] sel1,
                                    input wire sel,
                                    output wire [WIDTH-1:0] res);
	assign res = sel ? sel1 : sel0;  
endmodule