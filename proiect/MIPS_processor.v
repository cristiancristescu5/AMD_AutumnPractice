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
`include "add_32.v"
`include "concatenator.v"
`include "left_shift.v"
`include "controller.v"
`include "jump_address"
module MIPS_processor(input wire clk, input wire reset);
    wire [31:0] nextInstruction;
    wire [31:0] currentInstruction;
    wire [31:0] newAddress;
    wire [31:0] instruction;
    wire regDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    wire MemToReg;
    wire ALUop;
    wire MemWrite;
    wire AluSrc;
    wire RegWrite;
    wire Zero;
    program_counter program_counterDUT(
        .clk(clk),
        .reset(reset),
        .nextInstruction(nextInstruction),
        .currentInstruction(currentInstruction)
    );
    add addDUT(.address(currentInstruction),
                .newAddress(newAddress));
    instruction_memory instruction_memoryDUT(.readAdress(currentInstruction),
                                            .clk(clk),
                                            .reset(reset),
                                            .instruction(instruction)
                                            );
    wire [4:0] regD;
    mux #(.WIDTH(5)) mux_reg (.sel1(instruction[20:16]),
                            .sel2(instruction[15:11]),
                            .sel(regDst),
                            .res(regD));
    wire [31:0] dataAluMem;
    wire [31:0] fromRegS;
    wire [31:0] fromRegT;
    register_file register_fileDUT(.clk(clk),
                                    .regs(instruction[25:21]),
                                    .regt(instruction[20:16]),
                                    .regd(regD),
                                    .regWrite(RegWrite),
                                    .reset(reset),
                                    .dataWrite(dataAluMem),
                                    .reg1(fromRegS),
                                    .reg2(fromRegT));
    wire [31:0] imm;
    sign_extend sign_extendDUT(.instr(instruction),
                                .extension(imm));
    wire [5:0] aluSelection;
    alu_controller alu_controllerDUT(.ALUOp(ALUop),
                                        .AluSrc(AluSrc),
                                        .instruction(instruction),
                                        .selection(aluSelection));
    wire [31:0] aluMuxOut;
    mux #(.WIDTH(32)) aluMux(.sel1(fromRegT),
                            .sel2(imm),
                            .sel(AluSrc),
                            .res(aluMuxOut));
    wire [31:0] aluResult;
    alu aluDUT(.op1(fromRegS),
                .op2(aluMuxOut),
                .selection(aluSelection),
                .zero(Zero),
                .result(aluResult));
    wire [31:0] fromMemory;
    memory #(.SIZE(128)) memoryDUT(.address(aluResult),
                                    .data(fromRegT),
                                    .clk(clk),
                                    .memW(MemWrite),
                                    .memR(MemRead),
                                    .reset(reset),
                                    .readData(fromMemory)
                                    );
    mux #(.WIDTH(32)) memoryMux(.sel1(fromMemory),
                                .sel2(aluResult),
                                .sel(MemToReg),
                                .res(dataAluMem));
    controller controllerDUt(.instruction(instruction),
                            .RegDst(RegDst),
                            .reset(reset),
                            .Jump(Jump),
                            .Branch(Branch),
                            .MemRead(MemRead),
                            .AluOp(ALUop),
                            .MemWrite(MemWrite),
                            .AluSrc(AluSrc),
                            .RegWrite(RegWrite)
                            );
    wire [27:0] jumpAddr;
    jump_address jump_addressDUT(.address(instruction),
                                .extended(jumpAddr));
    wire [31:0] finalJ;
    concatenator concatenatorDUT(.shiftaddr(jumpAddr),
                                .addr(newAddress),
                                .finalAddr(finalJ));
    wire [31:0] immAddr;
    left_shift left_shiftDUT(.addr(imm),
                            .newAddr(immAddr));
    wire [31:0] add32Out;
    addFull addFullDUT(.a(newAddress),
                        .b(immAddr),
                        .sum(add32Out));
    wire andOut;
    assign andOut = Branch & Zero;
    wire [31:0] mux324Out;
    mux #(.WIDTH(32)) muxAdd32Add4 (.sel1(newAddress),
                                    .sel2(add32Out),
                                    .sel(andOut),
                                    .res(mux324Out));
    mux #(.WIDTH(32)) muxAddr (.sel1(mux324Out),
                                .sel2(newAddress),
                                .sel(Jump),
                                .res(nextInstruction));
endmodule