`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/15 18:43:29
// Design Name: 
// Module Name: sim
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim(
    );
    reg [5:0] opcode;
    reg [5:0] funct;
    reg [31:0] systemcall_argument_1;
    wire block_ins;
    wire block_s;
    wire RegDst; // 0: ins20_16; 1: ins15_11
    wire [1:0] Branch; // 0: no branch; 1: j || jal; 2: beq || bne; 3: jr
    wire MemRead; // 0: No read from Memory; 1: Read from Memory.
    wire MemtoReg; // 0: write data from ALU; 1: write data from Memory
    wire HwtoReg;
    reg [3:0] ALUOp; // according to document.md
    wire MemWrite; // 0: no write Memory; 1: write Memory
    reg ALUSrc; // 0: get data from Register; 1: get data from Sign-Extend
    wire RegWrite; // 0: no wirte Register; 1: write Register
    wire Jr; // 0: not a jr instruction
    wire Jal;// 0: not a jal instruction
    
//    Controller con(
//    .opcode(opcode),
//    .funct(funct),
//    .systemcall_argument_1(systemcall_argument_1),
//    .block_ins(block_ins),
//    .block_s(block_s),
//    .RegDst(RegDst),
//    .Branch(Branch),
//    .MemRead(MemRead),
//    .MemtoReg(MemtoReg),
//    .HwtoReg(HwtoReg),
//    .ALUOp(ALUOp),
//    .MemWrite(MemWrite),
//    .ALUSrc(ALUSrc),
//    .RegWrite(RegWrite),
//    .Jr(Jr),
//    .Jal(Jal)
//    );

    reg [31:0] read_data_1;
    reg [31:0] read_data_2;
    reg [31:0] sign_extended_data;
    reg [31:0] PC_address;
    wire zero_s;
    wire [31:0] result;
    
    ALU alu(
    .read_data_1(read_data_1),
    .read_data_2(read_data_2),
    .sign_extended_data(sign_extended_data),
    .ALUOp(ALUOp),
    .ALUSrc(ALUSrc),
    .PC_address(PC_address),
    .zero_s(zero_s),
    .block_s(block_s),
    .result(result)
    );
    
    initial begin
//       00042080
        read_data_1 = 32'hffff_ff81;
        read_data_2 = 32'h0000_0000;
        sign_extended_data = 32'h0000_27c2;
        PC_address = 32'h0000_0000;
        ALUOp = 4'hc;
        ALUSrc = 1'b0;
    end
    
endmodule
