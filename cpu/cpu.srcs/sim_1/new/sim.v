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
    reg clk;
    reg rst;
    wire [31:0] ins;
    wire clk23;
    wire [31:0] alu_result_o;
    wire alu_zero_s_o;
    wire [31:0] read_data1_o;
    wire [31:0] read_data2_o;
    wire [3:0] alu_op_o;
    Top top(clk, rst, ins, clk23, alu_result_o, alu_zero_s_o, read_data1_o,  read_data2_o, alu_op_o);
    
    always #5 clk = ~clk;
    
    initial begin
       clk = 1'b0;
       rst = 1'b0;
       #5000 rst = 1'b1;
    end
    
endmodule
