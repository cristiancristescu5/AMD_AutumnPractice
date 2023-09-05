module mux #(parameter WIDTH = 32)(input wire [WIDTH-1:0] sel1,
                                    input wire [WIDTH-1:0] sel2,
                                    input wire sel,
                                    output reg [WIDTH-1:0] res);
always @(*)begin 
    case(sel)
        1'b1:begin 
            res <= sel1;
        end
        1'b0:begin 
            res <=sel2;
        end
    endcase
end
endmodule