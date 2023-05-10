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
input [31:0]read_data_1,
input [31:0]read_data_2,
input [31:0]sign_extended_data,
input [3:0]ALUOp,
input [31:0]PC_address,
input ALUSrc, // 0: get data from Register; 1: get data from Sign-Extend
output reg zero_s, // compare result signal
output reg [31:0]result
);
reg [31:0]data1;
reg [31:0]data2;

always@(*)
begin
    data1 = read_data_1;
    data2 = ALUSrc ? sign_extended_data : read_data_2;
    zero_s = 1'b0;
    result = 32'b0;
    
    case(ALUOp)
        4'h0: begin // sll, sllv
            result = (data1 << data2);
        end
        4'h1: begin // srl, srlv
            result = (data1 >> data2);
        end
        4'h2: begin // sra, srav
            result = (data1 >>> data2);
        end
        4'h3: begin // add, addi, lw, sw, jr, jal
            result = data1 + data2;
            // throw error(maybe)
        end
        4'h4: begin // addu, addiu
            result = data1 + data2;
        end
        4'h5: begin // sub
            result = data1 - data2;
            // throw error(maybe)
        end
        4'h6: begin // subu
            result = data1 - data2;
        end
        4'h7: begin // and, andi
            result = data1 & data2;
        end
        4'h8: begin // or, ori
            result = data1 | data2;
        end
        4'h9: begin // xor, xori
            result = data1 ^ data2;
        end
        4'ha: begin // nor
            result = ~(data1 | data2);
        end
        4'hb: begin // slt, slti
            result = (data1 < data2);
        end
        4'hc: begin // sltu, sltiu
            if (data1[31] == 1'b1 && data2[31] == 1'b1) begin 
                result = (data1 > data2);
            end
            // both two data's sign-bit are 1
            else if (data1[31] == 1'b1 && data2[31] == 1'b0) begin
                result = 32'b0;
            end
            // data1's sign-bit is 1 and data2's sign-bit is 0
            else if (data1[31] == 1'b0 && data2[31] == 1'b1) begin
                result = 32'b1;
            end
            // data1's sign-bit is 0 and data2's sign-bit is 1
            else begin
                result = (data1 < data2);
            end
            // both two data's sign-bit are 0
        end
        4'hd: begin // beq
            zero_s = (data1 == data2);
            if (zero_s) begin
                result = PC_address + 3'b100 + (sign_extended_data << 2);
                // PC = PC + 4 + BranchAddr
            end
            // if beq instruction is true, then we need to return the next address.
        end
        4'he: begin // bne
            zero_s = (data1 != data2);
            if (zero_s) begin
                result = PC_address + 3'b100 + (sign_extended_data << 2);
                // PC = PC + 4 + BranchAddr
            end
            // if bne instruction is true, then we need to return the next address.
        end
        4'hf: begin // lui
            result = {data2[15:0],16'b0};
        end
    endcase
end

endmodule
