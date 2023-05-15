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
    input confirm_button,
    input [31:0] systemcall_argument_1,
    input [31:0] systemcall_argument_2,
    output reg [7:0] seg_een,
    output reg [7:0] seg_out0,
    output reg [7:0] seg_out1,
    output reg result_led,
    output reg hw_block_s,
    output reg [31:0] read_data
    );
    
    reg has_pressed;
    
    always @(posedge clk100) begin
        if (hw_block_s) begin
            case ({has_pressed, confirm_button})
                2'b00: begin
                    has_pressed = 1'b0;
                    hw_block_s = hw_block_s;
                end
                2'b01: begin
                    hw_block_s = hw_block_s;
                    has_pressed = 1'b1;
                end
                2'b10: begin
                    hw_block_s = 1'b0;
                    has_pressed = 1'b0;
                end
                2'b11: begin
                    has_pressed = 1'b1;
                    hw_block_s = hw_block_s;
                end
            endcase
        end else begin
            if (instruction == 32'hffff_ffff) begin
                case (systemcall_argument_1)
                    32'h0000_0000: begin
                        hw_block_s = 1'b1;
                    end
                    default: begin
                        hw_block_s = 1'b0;
                    end
                endcase
            end else begin
                hw_block_s = 1'b0;
            end
        end
    end
    
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
