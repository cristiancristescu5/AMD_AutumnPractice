module controller(input wire [31:0] instruction,
                   output reg RegDst,
                   input wire reset, 
                   output reg Jump,
                   output reg Branch,
                   output reg MemRead,
                   output reg MemtToReg,
                   output reg AluOp,
                   output reg MemWrite,
                   output reg AluSrc,
                   output reg regWrite);
localparam r = 6'b000000;
localparam lw = 6'b100011;
localparam sw = 6'b101011;
localparam ai = 6'b001000;
localparam di = 6'b001100;
localparam ori = 6'b001101;
localparam be = 6'b000100;
localparam j = 6'b000010;
localparam idle = 6'b111111;

reg [5:0] sc;
reg [5:0] sv;
reg [5:0] op;
 always @(instruction, sc) begin 
    sv <= op;
end
always @(posedge clk, posedge reset) begin 
    if(reset) begin 
        RegDst <= 0;
        Jump <=0;
        Branch <=0;
        MemRead <= 0;
        MemtToReg <= 0;
        AluOp <=0;
        MemWrite<=0;
        AluSrc <=0;
        regWrite <=0;
        sc <= idle;
        sv <= 6'bx;
    end else begin 
        sc <= sv;
    end
end

always @(sc) begin 
    case(sc) 
        idle: begin 
        RegDst <= 0;
        Jump <=0;
        Branch <=0;
        MemRead <= 0;
        MemtToReg <= 0;
        AluOp <=0;
        MemWrite<=0;
        AluSrc <=0;
        regWrite <=0;
        end
        r: begin 
            RegDst <= 1;
            Jump <=0;
            Branch <=0;
            MemRead <= 0;
            MemtToReg <= 0;
            AluOp <=1;
            MemWrite<=0;
            AluSrc <=0;
            regWrite <=1;
        end
        lw:begin 
            RegDst <=0;
            Jump<=0;
            Branch <=0;
            MemRead <= 1;
            MemtToReg <= 1;
            AluOp <=1;
            AluSrc <=1;
            regWrite<=1;
          	MemWrite <=0;
        end
        sw: begin 
            RegDst <=0;
            Jump <=0;
            Branch <=0;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=1;
            AluSrc <=1;
            regWrite <=0;
          	MemWrite <= 1;
        end
        ai:begin 
             RegDst <= 0;
            Jump <= 0;
            Branch <=0;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=1;
            AluSrc <=1;
            MemWrite <=0;
            regWrite <=1;
        end
        di: begin 
            RegDst <= 0;
            AluSrc <= 1;
            AluOp <=1;
            Jump <=0;
            Branch <= 0;
            regWrite <= 1;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end
        ori: begin 
            RegDst <= 0;
            AluSrc <= 1;
            AluOp <=1;
            Jump <=0;
            Branch <= 0;
            regWrite <= 1;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end
        be: begin 
            RegDst <= 0;
            Jump <= 0;
            Branch <=1;
            MemRead <=0;
            MemtToReg <=0;
            AluOp <=1;
            AluSrc <=1;
            MemWrite <=0;
            regWrite <=0;
        end
        j: begin 
            RegDst <= 0;
            AluSrc <= 0;
            AluOp <=0;
            Jump <=1;
            Branch <= 0;
            regWrite <= 0;
            MemtToReg <= 0;
            MemRead <= 0;
            MemWrite <= 0;
        end

    endcase
end


endmodule