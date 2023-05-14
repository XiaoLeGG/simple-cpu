`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 21:49:49
// Design Name: 
// Module Name: Top
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


module Top(
    input raw_clock
    );
    wire clk23;
    wire [31:0] pc_output_address_o;
    wire [31:0] ifetch_instruction_o;
    wire controller_RegDst;
    wire [1:0] controller_Branch;
    wire controller_MemRead;
    wire controller_MemtoReg;
    wire controller_ALUOp;
    wire controller_MemWrite;
    wire controller_ALUSrc;
    wire controller_RegWrite;
    wire controller_Jr;
    wire controller_Jal;
    wire [31:0] idecoder_read_data_1;
    wire [31:0] idecoder_read_data_2;
    wire alu_zero_s;
    wire [31:0] alu_result;
    wire [31:0] dmemory_read_data;
    wire [31:0] sign_extend_data32;
    
    wire rst;
    wire block_s;
    
    cpuclk cpu_clock(.clk_in1(raw_clock), .clk_out1(clk23));
    PC pc(
    .rst(rst),
    .clk(clk23),
    .branch_s(controller_Branch),
    .zero_s(alu_zero_s),
    .block_s(block_s),
    .jump_address26(ifetch_instruction_o[25:0]),
    .jump_address32(alu_result),
    .address_o(pc_output_address_o));
    
    IFetch ifetch(
    .address_i(pc_output_address_o),
    .clk(clk23),
    .instruction_o(ifetch_instruction_o)
    );
    
    Controller controller(
    .opcode(ifetch_instruction_o[31:26]),
    .funct(ifetch_instruction_o[5:0]),
    .RegDst(controller_RegDst),
    .Branch(controller_Branch),
    .MemRead(controller_MemRead),
    .MemtoReg(controller_MemtoReg),
    .ALUOp(controller_ALUOp),
    .MemWrite(controller_MemWrite),
    .ALUSrc(controller_ALUSrc),
    .RegWrite(controller_RegWrite),
    .Jr(controller_Jr),
    .Jal(controller_Jal)
    );
    
    IDecoder idecoder(
    .rst(rst),
    .clk(clk23),
    .ins25_23(ifetch_instruction_o[25:21]),
    .ins20_16(ifetch_instruction_o[20:16]),
    .ins15_11(ifetch_instruction_o[15:11]),
    .RegDst(controller_RegDst),
    .RegWrite(controller_RegWrite),
    .Jr(controller_Jr),
    .Jal(controller_Jal),
    .MemtoReg(controller_MemtoReg),
    .PC_address(pc_output_address_o),
    .alu_data(alu_result),
    .mem_data(dmemory_read_data),
    .read_data_1(idecoder_read_data_1),
    .read_data_2(idecoder_read_data_2)
    );
    
    Alu alu(
    .read_data_1(idecoder_read_data_1),
    .read_data_2(idecoder_read_data_2),
    .sign_extended_data(sign_extend_data32),
    .ALUOp(controller_ALUOp),
    .ALUSrc(controller_ALUSrc),
    .zero_s(alu_zero_s),
    .result(alu_result)
    );
    
    
    
endmodule
