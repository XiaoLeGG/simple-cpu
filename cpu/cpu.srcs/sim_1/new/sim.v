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
    reg [7:0] data_switch;
    reg confirm_button;
    wire block_led;
    wire error_led;
    wire result_led;
    wire [7:0] seg_en;
    wire [7:0] seg_out0;
    wire [7:0] seg_out1;
    wire [31:0] ifetch_instruction_o_2;
    wire clk23_o;
    wire [31:0] pc_address_o;
    Top top(clk, rst, data_switch, confirm_button, block_led, error_led, result_led, seg_en, seg_out0, seg_out1, ifetch_instruction_o_2, clk23_o, pc_address_o);
    
    always #5 clk = ~clk;
    
    initial begin
       clk = 1'b0;
       rst = 1'b0;
       data_switch = 8'b1111_0000;
       #5000 rst = 1'b1;
       #1000 confirm_button = 1'b1;
       #10 confirm_button = 1'b0;
    end
    
endmodule
