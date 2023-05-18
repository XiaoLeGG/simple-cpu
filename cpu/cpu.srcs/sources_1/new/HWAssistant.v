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
    output [7:0] seg_en,
    output [7:0] seg_out0,
    output [7:0] seg_out1,
    output result_led,
    output reg negative_led,
    output reg [31:0] read_data
    );
    
    reg [31:0] display_number;
    reg [1:0] led_type;

    refresh_seg_led rsl(
        .binary(display_number),
        .clk(clk100),
        .rst_n(rst),
        .seg_en(seg_en),
        .seg_out0(seg_out0),
        .seg_out1(seg_out1)
    );

    light_control(
        .clk100(clk100),
        .rst_n(rst),
        .led_type(led_type),
        .result_led(result_led)
    );
    
    always @(rst, instruction, systemcall_argument_1, systemcall_argument_2, data_switch) begin
        if (~rst) begin
            read_data = 32'h0000_0000;
            display_number = 32'h0000_0000;
            led_type = 2'b00;
            negative_led = 1'b0;
        end else begin
        if (instruction == 32'hffff_ffff) begin
            case (systemcall_argument_1)
                32'h0000_0000: begin // $v0 = 0, read data is signed.
                    read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
                end
                32'h0000_0001: begin // $v0 = 1. read data is unsigned
                    read_data = {24'h000000, data_switch};
                end
                32'h0000_0002: begin
                    if (systemcall_argument_2[31:31] == 1'b1) begin
                        display_number = ~(systemcall_argument_2 - 1'b1);
                        negative_led = 1'b1;
                    end
                    else begin
                        display_number = systemcall_argument_2;
                        negative_led = 1'b0;
                    end
                end
                32'h0000_0003: begin // unsigned number
                    display_number = systemcall_argument_2;
                    negative_led = 1'b0;
                end
                32'h0000_0004: begin
                    led_type = systemcall_argument_2[1:0];
                end
                default: begin
                    //read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
                end
            endcase
        end else begin
            read_data = {(data_switch[7] ? 24'hffffff : 24'h000000), data_switch};
        end
    end
    end
endmodule
