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
    input key,
    output reg key_o
    ); 
reg [31:0] cnt_press;
reg [31:0] cnt_release;

parameter cnt_check = 100000;

always@(posedge clk) begin
    if(key == 1'b1) begin
        if (cnt_press <= cnt_check) begin
            cnt_press <= cnt_press + 32'b1;
        end else begin
            cnt_press <= cnt_press;
        end
        cnt_release <= 32'b0;
    end
    else begin
        if (cnt_release <= cnt_check) begin
            cnt_release <= cnt_release + 32'b1;
        end else begin
            cnt_release <= cnt_release;
        end
        cnt_press <= 32'b0;
    end
end

always @(posedge clk) begin
    if (cnt_press >= cnt_check) begin
        key_o <= 1'b1;
    end
    else begin
        if (cnt_release >= cnt_check) begin
            key_o <= 1'b0;
        end else begin
            key_o <= key_o;
        end
    end
end

endmodule
