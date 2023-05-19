`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/19 19:59:35
// Design Name: 
// Module Name: key_scan
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


module key_scan(
    input clk,
    input rst_n,
    input key,
    output flag
    );
parameter cnt_1MS = 23000;

reg key_n;
reg key_r;
reg [31:0] cnt;

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 32'b0;
    end
    else if (cnt == cnt_1MS) begin
        cnt <= 1'b0;
    end
    else begin
        cnt <= cnt + 1'b1;
    end
end

always@(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        key_n <= 1'b1;
        key_r <= 1'b1;
    end
    else if (cnt == cnt_1MS) begin
        key_n <= key;
        key_r <= key_n;
    end
    else begin
        key_n <= key_n;
        key_r <= key_r;
    end
end
assign flag = ~key_n & key_r;

endmodule
