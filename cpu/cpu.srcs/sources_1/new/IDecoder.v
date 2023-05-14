`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 10:31:26
// Design Name: 
// Module Name: IDecoder
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


module IDecoder(
    input rst,
    input clk,
    input [4:0]ins25_21,
    input [4:0]ins20_16,
    input [4:0]ins15_11,
    input RegDst,
    input RegWrite,
    input Jr,
    input Jal,
    input MemtoReg,
    input [31:0]PC_address,
    input [31:0]alu_data,
    input [31:0]mem_data,
    output reg [31:0]read_data_1,
    output reg [31:0]read_data_2
);
reg [31:0]register[0:31];
reg [4:0]write_register;

always@(*)
begin
    if (Jr == 1'b1) begin // jr instruction read $ra
        read_data_1 = register[31];
        read_data_2 = register[0];
    end
    else if (Jal == 1'b1) begin // jal instruction rewrite $ra
        read_data_1 = PC_address;
        read_data_2 = 3'b100;
    end
    else begin
        read_data_1 = register[ins25_21];
        read_data_2 = register[ins20_16];
    end
    
    if (Jal == 1'b1) begin // jal needs to rewrite $ra
        write_register = 5'b11110;
    end
    else begin
        write_register = RegDst ? ins15_11 : ins20_16;
    end
    //select the write register
end

always@(posedge clk, negedge rst)
begin
    register[0] = 32'h0000_0000;
    if (~rst) begin
//        register[1] = 32'h0000_0000;
//        register[2] = 32'h0000_0000;
//        register[3] = 32'h0000_0000;
//        register[4] = 32'h0000_0000;
//        register[5] = 32'h0000_0000;
//        register[6] = 32'h0000_0000;
//        register[7] = 32'h0000_0000;
//        register[8] = 32'h0000_0000;
//        register[9] = 32'h0000_0000;
//        register[10] = 32'h0000_0000;
//        register[11] = 32'h0000_0000;
//        register[12] = 32'h0000_0000;
//        register[13] = 32'h0000_0000;
//        register[14] = 32'h0000_0000;
//        register[15] = 32'h0000_0000;
//        register[16] = 32'h0000_0000;
//        register[17] = 32'h0000_0000;
//        register[18] = 32'h0000_0000;
//        register[19] = 32'h0000_0000;
//        register[20] = 32'h0000_0000;
//        register[21] = 32'h0000_0000;
    end else begin
        if (RegWrite == 1'b1) begin
            if (write_register == 5'b00000) begin
                register[write_register] = 32'h0000_0000;
            end
            else begin
                register[write_register] = MemtoReg ? mem_data : alu_data;
            end
        end else begin
            register[write_register] = register[write_register];
        end
    end
end
endmodule
