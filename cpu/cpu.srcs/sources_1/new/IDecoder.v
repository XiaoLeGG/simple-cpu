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
    input [4:0] ins25_21,
    input [4:0] ins20_16,
    input [4:0] ins15_11,
    input RegDst,
    input RegWrite,
    input Jr,
    input Jal,
    input MemtoReg,
    input HwtoReg,
    input [31:0] PC_address,
    input [31:0] alu_data,
    input [31:0] mem_data,
    input [31:0] hw_data,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2,
    output reg [31:0] systemcall_argument_1,
    output reg [31:0] systemcall_argument_2
);
reg [31:0]register[0:31];
reg [4:0]write_register;

always@(*)
begin
    systemcall_argument_1 = register[2];
    systemcall_argument_2 = register[4];
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

integer m;

always@(posedge clk, negedge rst)
begin
    register[0] = 32'h0000_0000;
    if (~rst) begin
        register[28] = 32'h1000_8000;
        register[29] = 32'h7fff_effc;
        
        for (m = 0; m < 32; m = m + 1) begin
            if (m != 28 && m != 29) begin
                register[m] = 32'h0000_0000;
            end
        end
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
