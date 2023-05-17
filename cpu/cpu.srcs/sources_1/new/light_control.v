`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 20:52:43
// Design Name: 
// Module Name: light_control
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


module light_control(
    input clk100,
    input rst_n,
    input [1:0] led_type,
    output reg result_led
    );

    reg [31:0] cnt;

    always@(posedge clk100, negedge rst_n) begin
        if (~rst_n) begin
            cnt <= 0;
            result_led <= 0;
        end
        else begin
            if (led_type == 2'b00) begin
                result_led <= 1'b0;
            end
            else if (led_type == 2'b01) begin
                result_led <= 1'b1;
            end
            else begin
                if (cnt == 32'd49_999_999) begin
                    result_led <= ~result_led;
                    cnt <= 0;
                end
                else begin
                    cnt <= cnt + 1;
                    result_led <= result_led;
                end
            end
        end
    end
endmodule
