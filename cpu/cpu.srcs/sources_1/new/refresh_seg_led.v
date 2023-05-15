`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/16 00:04:48
// Design Name: 
// Module Name: refresh_seg_led
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


module refresh_seg_led(
    input [31:0] binary,
    input clk,
    input rst_n,
    output reg [7:0] seg_en,
    output [7:0] seg_out0,
    output [7:0] seg_out1 
);

parameter period = 200000;

reg [31:0] cnt;
reg clkout;

reg [3:0] number;
reg [2:0] digit;


always @(posedge clk, negedge rst_n) 
begin
    if(~rst_n)
    begin 
        cnt <= 0;
        clkout <= 0;
    end 
    else 
    begin
        if(cnt == (period >> 1) - 1) 
        begin
            clkout <= ~clkout;
            cnt <= 0;
        end 
        else
            cnt <= cnt + 1;
    end
end

reg [31:0] bcd;

always @(binary) begin
    
end

always @(posedge clkout, negedge rst_n)
begin
    if(~rst_n)
    begin
        digit <= 0;
    end
    else
    begin
        if(digit == 3'd7)
            digit <= 0;
        else
            digit <= digit + 1;
    end
end

always @(digit)
begin
    casex({~rst_n, digit})
        4'b1xxx: begin seg_en <= 8'h00; number <= bcd[3:0]; end
        4'd0: begin seg_en <= 8'b0000_0001; number <= bcd[3:0]; end
        4'd1: begin seg_en <= 8'b0000_0010; number <= bcd[7:4]; end
        4'd2: begin seg_en <= 8'b0000_0100; number <= bcd[11:8]; end
        4'd3: begin seg_en <= 8'b0000_1000; number <= bcd[15:12]; end
        4'd4: begin seg_en <= 8'b0001_0000; number <= bcd[19:16]; end
        4'd5: begin seg_en <= 8'b0010_0000; number <= bcd[23:20]; end
        4'd6: begin seg_en <= 8'b0100_0000; number <= bcd[27:24]; end
        4'd7: begin seg_en <= 8'b1000_0000; number <= bcd[31:28]; end
    endcase
end

light_7seg_ego1 l1({digit,number}, seg_out1);
light_7seg_ego1 l0({digit,number}, seg_out0);
endmodule

