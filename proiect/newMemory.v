module memory #(parameter SIZE = 32)(input wire [31:0] address,
                                    input wire [31:0] data,
                                    input wire clk,
                                    input wire memW,
                                    input wire memR,
                                    input wire reset,
                                    output reg [31:0] readData);
reg [31 : 0] memory [0 : SIZE-1];
reg [31:0] index;
initial begin 
    for(index = 0 ; index < SIZE ; index = index + 1)begin 
            memory[index]<=32'b0;
        end
    index <= 32'b0;
end
always @(posedge clk)begin 
    if(reset)begin 
        for(index = 0 ; index < SIZE ; index = index + 1)begin 
            memory[index]<=32'b0;
        end
        index <= 32'b0;
    end else begin
        if(address <= SIZE - 1) begin 
            if(memW)begin 
                if(!memR)begin 
                    memory[address] <= data;
                    $display("scriu in memorie");
                end
            end else begin 
                if(memR)begin 
                    readData <= memory[address];
                    $display("citesc din memorie");
                end
            end
        end else begin 
            if(memR && !memW)begin 
                readData <= 32'hx;
                $display("nu fac nimic");
            end
        end
    end
  $display("memorie: %h", data);
  $display("address: %h", address);
end
endmodule

        // if(address <= SIZE-1) begin 
        //     case (memW)
        //         1'b1:begin 
        //             if(memR == 1'b0)begin 
        //                 memory[address] <=data;
        //               $display("scriu in memorie");
        //             end
        //         end
        //         1'b0:begin
        //             if(memR == 1'b1) begin 
        //                 readData <= memory[address];
        //               $display("citesc din memorie");
        //             end
        //         end
        //     endcase
        // end else begin 
        //     if(memW == 1'b0 && memR == 1'b1)begin 
        //         readData <= 32'hx;
        //     end
        // end