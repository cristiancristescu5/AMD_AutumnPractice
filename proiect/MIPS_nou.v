`include "program_counter.v"
`include "add.v"
`include "add_32.v"
`include "instruction_memory.v"
`include "mux.v"
`include "register_file.v"
`include "sign_extend.v"
`include "alu_controller.v"
`include "alu.v"
`include "memory.v"
`include "concatenator.v"
`include "left_shift.v"
`include "controller.v"
`include "jump_address.v"
module mips(input wire clk,
            input wire reset,
            output wire [31 : 0] address,
            output wire [31 : 0] result,
            output wire [31:0] instruction);
wire regDst;
wire regWrite;
wire jump;
wire branch;
wire memRead;
wire memToReg;
wire aluOp;
wire memWrite;
wire aluSrc;
wire zero;
wire andOut;

wire [31:0] fromMemory; 
wire [31:0] aluOut;
wire [31:0] currentAddress;
wire [31:0] nextAddress;
wire [31:0] currentInstruction;
wire [4:0] regDest;
wire [31:0] aluMemData;
wire [31:0] reg1, reg2;
wire [31:0] immext;
wire [5:0] aluSelection;
wire [31:0] aluIn2;
wire [31:0] address4;
wire [27:0] shiftJump;
wire [31:0] finalJump; 
wire [31:0] immAdd;
wire [31:0] immAdd4;
wire [31:0] immMuxOut;
  wire [31:0] nextTmp;
  
  assign nextTmp = nextAddress;
  assign address = currentAddress;
  assign result = aluMemData;
mux #(.WIDTH(32)) muxFinalAdd(.sel0(immMuxOut),
                            .sel1(finalJump),
                            .sel(jump),
                            .res(nextAddress));
program_counter prog(.clk(clk),
                    .reset(reset),
                     .nextInstruction(nextAddress),
                    .currentInstruction(currentAddress));
instruction_memory #(.SIZE(128)) imem(.readAdress(currentAddress),
                                        .clk(clk),
                                        .reset(reset),
                                        .instruction(currentInstruction));
  assign instruction = currentInstruction;
controller control(.instruction(currentInstruction),
                    .RegDst(regDst),
                    .reset(reset),
                    .Jump(jump),
                    .Branch(branch),
                    .MemRead(memRead),
                    .MemtToReg(memToReg),
                    .AluOp(aluOp),
                    .MemWrite(memWrite),
                    .AluSrc(aluSrc),
                    .regWrite(regWrite));


mux #(.WIDTH(5)) muxReg (.sel0(currentInstruction[20:16]),
                        .sel1(currentInstruction[15:11]),
                        .sel(regDst),
                        .res(regDest));
register_file regFile(.clk(clk),
                        .regs(currentInstruction[25:21]),
                        .regt(currentInstruction[20:16]),
                        .regd(regDest),
                        .regWrite(regWrite),
                        .reset(reset),
                        .dataWrite(aluMemData),
                        .reg1(reg1),
                        .reg2(reg2));

sign_extend se(.instr(currentInstruction),
                .extension(immext));
  alu_controller aluControl(.ALUOp(aluOp),
                            .AluSrc(aluSrc),
                            .instruction(currentInstruction),
                            .selection(aluSelection));

mux #(.WIDTH(32)) aluMux(.sel0(reg2),
                        .sel1(immext),
                        .sel(aluSrc),
                        .res(aluIn2));

alu aluModule(.op1(reg1),
                .op2(aluIn2),
                .selection(aluSelection),
                .zero(zero),
                .result(aluOut));

memory #(.SIZE(128)) dataMem(.address(aluOut),
                            .data(reg2),
                            .clk(clk),
                            .memW(memWrite),
                            .memR(memRead),
                            .reset(reset),
                            .readData(fromMemory));
mux #(.WIDTH(32)) aluMemMux(.sel0(aluOut),
                            .sel1(fromMemory),
                            .sel(memToReg),
                            .res(aluMemData));
add add4(.address(currentAddress),
        .newAddress(address4));
jump_address jumpadd(.address(currentAddress),
                    .extended(shiftJump));

concat concatMod(.shiftaddr(shiftJump),
                    .addr(address4),
                    .finalAddr(finalJump));
left_shift ls(.addr(immext),
                .newAddr(immAdd));

addFull addF(.a(address4),
        .b(immAdd),
        .sum(immAdd4));
  and(andOut, branch, zero);
mux #(.WIDTH(32)) muxImm4(.sel0(address4),
                            .sel1(immAdd4),
                            .sel(andOut),
                            .res(immMuxOut));

    endmodule