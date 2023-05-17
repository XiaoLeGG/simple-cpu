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
    input raw_clock,
    input hard_ware_rst,
    input [7:0] data_switch,
    input confirm_button,
    output block_led,
    output error_led,
    output result_led,
    output wire[7:0] seg_en,
    output wire[7:0] seg_out0,
    output wire[7:0] seg_out1
);
    
    wire clk23;
    wire [31:0] pc_output_address_o;
    wire [31:0] ifetch_instruction_o;
    wire controller_RegDst;
    wire [1:0] controller_Branch;
    wire controller_MemRead;
    wire controller_MemtoReg;
    wire [3:0] controller_ALUOp;
    wire controller_MemWrite;
    wire controller_ALUSrc;
    wire controller_RegWrite;
    wire controller_Jr;
    wire controller_Jal;
    wire controller_HwtoReg;
    wire controller_block_ins;
    wire [31:0] idecoder_read_data_1;
    wire [31:0] idecoder_read_data_2;
    wire alu_zero_s;
    wire [31:0] alu_result;
    wire [31:0] dmemory_read_data;
    wire [31:0] sign_extend_data32;
    
    wire [31:0] idecoder_systemcall_argument_1;
    wire [31:0] idecoder_systemcall_argument_2;
    
//    assign clk23_o = clk23;
//    assign ifetch_instruction_o_2 = ifetch_instruction_o;
//    assign pc_address_o = pc_output_address_o;
//    assign alu_result_o = alu_result;
//    assign alu_zero_s_o = alu_zero_s;
//    assign read_data1_o = idecoder_read_data_1;
//    assign read_data2_o = idecoder_read_data_2;
//    assign alu_op_o = controller_ALUOp;
    
    wire rst;
    assign rst = hard_ware_rst;
    wire block_s;
    
    wire [31:0] hwassistant_read_data;
    
    assign block_led = block_s | controller_block_ins;
    
    HWAssistant hwass(
    .rst(rst),
    .clk100(raw_clock),
    .instruction(ifetch_instruction_o),
    .data_switch(data_switch),
    .systemcall_argument_1(idecoder_systemcall_argument_1),
    .systemcall_argument_2(idecoder_systemcall_argument_2),
    .seg_en(seg_en),
    .seg_out0(seg_out0),
    .seg_out1(seg_out1),
    .result_led(result_led),
    .read_data(hwassistant_read_data)
    );
    
    cpuclk cpu_clock(.clk_in1(raw_clock), .clk_out1(clk23));
    PC pc(
    .rst(rst),
    .clk(clk23),
    .branch_s(controller_Branch),
    .zero_s(alu_zero_s),
    .block_ins(controller_block_ins),
    .block_s(block_s),
    .confirm_button(confirm_button),
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
    .systemcall_argument_1(idecoder_systemcall_argument_1),
    .block_ins(controller_block_ins),
    .block_s(block_s),
    .RegDst(controller_RegDst),
    .Branch(controller_Branch),
    .MemRead(controller_MemRead),
    .MemtoReg(controller_MemtoReg),
    .HwtoReg(controller_HwtoReg),
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
    .ins25_21(ifetch_instruction_o[25:21]),
    .ins20_16(ifetch_instruction_o[20:16]),
    .ins15_11(ifetch_instruction_o[15:11]),
    .RegDst(controller_RegDst),
    .RegWrite(controller_RegWrite),
    .Jr(controller_Jr),
    .Jal(controller_Jal),
    .MemtoReg(controller_MemtoReg),
    .HwtoReg(controller_HwtoReg),
    .PC_address(pc_output_address_o),
    .alu_data(alu_result),
    .mem_data(dmemory_read_data),
    .hw_data(hwassistant_read_data),
    .read_data_1(idecoder_read_data_1),
    .read_data_2(idecoder_read_data_2),
    .systemcall_argument_1(idecoder_systemcall_argument_1),
    .systemcall_argument_2(idecoder_systemcall_argument_2)
    );
    
    ALU alu(
    .read_data_1(idecoder_read_data_1),
    .read_data_2(idecoder_read_data_2),
    .sign_extended_data(sign_extend_data32),
    .ALUOp(controller_ALUOp),
    .ALUSrc(controller_ALUSrc),
    .PC_address(pc_output_address_o),
    .zero_s(alu_zero_s),
    .error_led(error_led),
    .result(alu_result)
    );
    
    DMemory dmemory(
    .clk(clk23),
    .MemRead(controller_MemRead),
    .MemWrite(controller_MemWrite),
    .address_i(alu_result),
    .write_data(idecoder_read_data_2),
    .read_data(dmemory_read_data)
    );
    
    Sign_Extend sign_extend(
    .ins15_0(ifetch_instruction_o[15:0]),
    .data32(sign_extend_data32)
    );
    
endmodule
