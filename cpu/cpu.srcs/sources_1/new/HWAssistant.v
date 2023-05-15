`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/15 22:58:24
// Design Name: 
// Module Name: HWAssistant
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


module HWAssistant(
    input rst,
    input clk100,
    input [31:0] instruction,
    input [7:0] data_switch,
    input [31:0] systemcall_argument_1,
    input [31:0] systemcall_argument_2,
    output reg [7:0] seg_een,
    output reg [7:0] seg_out0,
    output reg [7:0] seg_out1,
    output reg result_led,
    output reg [31:0] read_data
    );
    
    reg has_pressed;
    
    always @(*) begin
        if (instruction == 32'hffff_ffff) begin
            case (systemcall_argument_1)
                32'h0000_0000: begin
                    read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
                end
                32'h0000_0001: begin
                    read_data = {24'h000000, data_switch};
                end
                default: begin
                    read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
                end
            endcase
        end else begin
            read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
        end
    end
    
endmodule
