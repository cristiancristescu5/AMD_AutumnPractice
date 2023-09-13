module mux #(parameter WIDTH = 32)(input wire [WIDTH-1:0] sel0,
                                    input wire [WIDTH-1:0] sel1,
                                    input wire sel,
                                    output reg [WIDTH-1:0] res);
always @(*)begin

  if(sel)begin 
    res <= sel1;
  end else begin 
    res <= sel0;
  end

end
  
endmodule
