`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 09:23:32
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] read_data_1,
    input [31:0] read_data_2,
    input [31:0] sign_extended_data,
    input [3:0] ALUOp,
    input ALUSrc, // 0: get data from Register; 1: get data from Sign-Extend
    input [31:0] PC_address,
    output reg zero_s, // compare result signal
    output reg block_s,
    output reg [31:0] result
);

always@(*)
begin
    case(ALUOp)
        4'h0: begin // sll, sllv
            result = (read_data_1 << (ALUSrc ? sign_extended_data : read_data_2));
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h1: begin // srl, srlv
            result = (read_data_1 >> (ALUSrc ? sign_extended_data : read_data_2));
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h2: begin // sra, srav
            result = (read_data_1 >>> (ALUSrc ? sign_extended_data : read_data_2));
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h3: begin // add, addi, lw, sw, jr, jal
            result = read_data_1 + (ALUSrc ? sign_extended_data : read_data_2);
            
            zero_s = 1'b0;
            
            block_s = 1'b0;
            // throw error(maybe)
        end
        4'h4: begin // addu, addiu
            result = read_data_1 + (ALUSrc ? sign_extended_data : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h5: begin // sub
            result = read_data_1 - (ALUSrc ? sign_extended_data : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
            // throw error(maybe)
        end
        4'h6: begin // subu
            result = read_data_1 - (ALUSrc ? sign_extended_data : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h7: begin // and, andi
            result = read_data_1 & (ALUSrc ? sign_extended_data : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h8: begin // or, ori
            result = read_data_1 | (ALUSrc ? {16'h0000, sign_extended_data[15:0]} : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'h9: begin // xor, xori
            result = read_data_1 ^ (ALUSrc ? {16'h0000, sign_extended_data[15:0]} : read_data_2);
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'ha: begin // nor
            result = ~(read_data_1 | (ALUSrc ? sign_extended_data : read_data_2));
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'hb: begin // slt, slti
            result = (read_data_1 < (ALUSrc ? sign_extended_data : read_data_2));
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        4'hc: begin // sltu, sltiu
            if (read_data_1[31] == 1'b1 && (ALUSrc ? sign_extended_data[31] : read_data_2[31]) == 1'b1) begin 
                result = {31'h0000_0000, (read_data_1 > (ALUSrc ? sign_extended_data : read_data_2))};
                zero_s = 1'b0;
                block_s = 1'b0;
            end
            // both two data's sign-bit are 1
            else if (read_data_1[31] == 1'b1 && (ALUSrc ? sign_extended_data[31] : read_data_2[31]) == 1'b0) begin
                result = 32'h0000_0000;
                zero_s = 1'b0;
                block_s = 1'b0;
            end
            // data1's sign-bit is 1 and data2's sign-bit is 0
            else if (read_data_1[31] == 1'b0 && (ALUSrc ? sign_extended_data[31] : read_data_2[31]) == 1'b1) begin
                result = 32'h0000_0001;
                zero_s = 1'b0;
                block_s = 1'b0;
            end
            // data1's sign-bit is 0 and data2's sign-bit is 1
            else begin
                result = {31'h0000_0000, (read_data_1 < (ALUSrc ? sign_extended_data : read_data_2))};
                zero_s = 1'b0;
                block_s = 1'b0;
            end
            // both two data's sign-bit are 0
        end
        4'hd: begin // beq
            
            if (read_data_1 == (ALUSrc ? sign_extended_data : read_data_2)) begin
                zero_s = 1'b1;
                result = PC_address + 3'b100 + (sign_extended_data << 2);
                block_s = 1'b0;
                // PC = PC + 4 + BranchAddr
            end else begin
                zero_s = 1'b0;
                result = 32'h0000_0000;
                block_s = 1'b0;
            end
            // if beq instruction is true, then we need to return the next address.
        end
        4'he: begin // bne
            
            if (read_data_1 != (ALUSrc ? sign_extended_data : read_data_2)) begin
                result = PC_address + 3'b100 + (sign_extended_data << 2);
                zero_s = 1'b1;
                block_s = 1'b0;
                // PC = PC + 4 + BranchAddr
            end else begin
                result = 32'h0000_0000;
                zero_s = 1'b0;
                block_s = 1'b0;
            end
            // if bne instruction is true, then we need to return the next address.
        end
        4'hf: begin // lui
            result = {(ALUSrc ? sign_extended_data[15:0] : read_data_2[15:0]),16'h0000};
            zero_s = 1'b0;
            block_s = 1'b0;
        end
        default: begin
            result = 32'h0000_0000;
            zero_s = 1'b0;
            block_s = 1'b0;
        end
    endcase
end

endmodule
