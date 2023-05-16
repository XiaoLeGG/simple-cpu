`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 20:44:22
// Design Name: 
// Module Name: Controller
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


module Controller(
    input [5:0] opcode, // instruction[31:26]
    input [5:0] funct, // instruction[5:0]
    input [31:0] systemcall_argument_1,
    output reg block_ins,
    output reg block_s,
    output reg RegDst, // 0: ins20_16; 1: ins15_11
    output reg [1:0] Branch, // 0: no branch; 1: j || jal; 2: beq || bne; 3: jr
    output reg MemRead, // 0: No read from Memory; 1: Read from Memory.
    output reg MemtoReg, // 0: write data from ALU; 1: write data from Memory
    output reg HwtoReg,
    output reg [3:0] ALUOp, // according to document.md
    output reg MemWrite, // 0: no write Memory; 1: write Memory
    output reg ALUSrc, // 0: get data from Register; 1: get data from Sign-Extend
    output reg RegWrite, // 0: no wirte Register; 1: write Register
    output reg Jr, // 0: not a jr instruction
    output reg Jal // 0: not a jal instruction
);



always@(*)
begin
    // add || addu || and || nor
    // || or || slt || sltu || sll
    // || srl || sub || subu || sllv
    // || srlv || sra || srav || xor
    RegDst = (opcode == 6'h00) &&
             (funct == 6'h20 || funct == 6'h21 || funct == 6'h24 || funct == 6'h27
             || funct == 6'h25 || funct == 6'h2a || funct == 6'h2b || funct == 6'h00
             || funct == 6'h02 || funct == 6'h22 || funct == 6'h23 || funct == 6'h04
             || funct == 6'h06 || funct == 6'h03 || funct == 6'h07 || funct == 6'h26);
    
    
    case(opcode)
        6'h02, 6'h03: begin // j || jal
            Branch = 2'b01;
        end
        6'h05, 6'h04: begin // beq || bne
            Branch = 2'b10;
        end
        6'h00: begin
            if(funct == 6'h08) begin // jr
                Branch = 2'b11;
            end
            else begin
                Branch = 2'b00;
            end
        end
        default: begin
            Branch = 2'b00;
        end
    endcase

    block_ins = (opcode == 6'b111111 && funct == 6'b111111) && (systemcall_argument_1 == 32'h0000_0000 || systemcall_argument_1 == 32'h0000_0001);
    
    // lbu || lhu || ll || lw
    MemRead = (opcode == 6'h24 || opcode == 6'h25 || opcode == 6'h30 || opcode == 6'h23);
    
    // lbu || lhu || ll || lw
    MemtoReg = (opcode == 6'h24 || opcode == 6'h25 || opcode == 6'h30 || opcode == 6'h23);
    
    HwtoReg = (opcode == 6'b111111 && funct == 6'b111111) && (systemcall_argument_1 == 32'h0000_0000 || systemcall_argument_1 == 32'h0000_0001);
    
    // sb || sc || sh || sw
    MemWrite = (opcode == 6'h28 || opcode == 6'h38 || opcode == 6'h29 || opcode == 6'h2b);
    
     // addi || addiu || lbu || lhu
    // || ll || lw || slti || sltiu
    // || sb || sc || sh || sw
    // || andi || ori || xori || lui
    ALUSrc = (opcode == 6'h08 || opcode == 6'h09 || opcode == 6'h24 || opcode == 6'h25
              || opcode == 6'h30 || opcode == 6'h23 || opcode == 6'h0a || opcode == 6'h0b
              || opcode == 6'h28 || opcode == 6'h38 || opcode == 6'h29 || opcode == 6'h2b
              || opcode == 6'h0c || opcode == 6'h0d || opcode == 6'h0e || opcode == 6'h0f);

    // add || addu || and
    // || nor || or || slt || sltu
    // || sll || srl || sub || subu
    // || sllv || srlv || sra || srav
    // || xor || addi || addiu || andi
    // || jal || lbu || lhu || ll
    // || lui || lw || ori || slti
    // || sltiu || systemcall with v0 = 0
    RegWrite = ((opcode == 6'h00 && (funct == 6'h20 || funct == 6'h21 || funct == 6'h24
                || funct == 6'h27 || funct == 6'h25 || funct == 6'h2a || funct == 6'h2b
                || funct == 6'h00 || funct == 6'h02 || funct == 6'h22 || funct == 6'h23
                || funct == 6'h04 || funct == 6'h06 || funct == 6'h03 || funct == 6'h07
                || funct == 6'h26)) || (opcode == 6'h08 || opcode == 6'h09 || opcode == 6'h0c
                || opcode == 6'h03 || opcode == 6'h24 || opcode == 6'h25 || opcode == 6'h30
                || opcode == 6'h0f || opcode == 6'h23 || opcode == 6'h0d || opcode == 6'h0a
                || opcode == 6'h0b))
                || (opcode == 6'b111111 && funct == 6'b111111 && systemcall_argument_1 == 32'h0000_0000);
    
                
    Jr = (opcode == 6'h00 && funct == 6'h08); // jr
    
    Jal = (opcode == 6'h03); // jal
    
    case(opcode)
        6'h00: begin
            case(funct)
                6'h00, 6'h04: begin // sll, sllv
                    ALUOp = 4'h0;
                end
                6'h02, 6'h06: begin // srl, srlv
                    ALUOp = 4'h1;
                end
                6'h03, 6'h07: begin // sra, srav
                    ALUOp = 4'h2;
                end
                6'h20, 6'h08: begin // add, jr
                    ALUOp = 4'h3;
                end
                6'h21: begin // addu
                    ALUOp = 4'h4;
                end
                6'h22: begin // sub
                    ALUOp = 4'h5;
                end
                6'h23: begin // subu
                    ALUOp = 4'h6;
                end
                6'h24: begin // and
                    ALUOp = 4'h7;
                end
                6'h25: begin // or
                    ALUOp = 4'h8;
                end
                6'h26: begin // xor
                    ALUOp = 4'h9;
                end
                6'h27: begin // nor
                    ALUOp = 4'ha;
                end
                6'h2a: begin // slt
                    ALUOp = 4'hb;
                end
                6'h2b: begin // sltu
                    ALUOp = 4'hc;
                end
                default: begin
                end
            endcase
        end
        6'h08, 6'h23, 6'h2b, 6'h03: begin // addi, lw, sw, jal
            ALUOp = 4'h3;
        end
        6'h09: begin // addiu
            ALUOp = 4'h4;
        end
        6'h0c: begin // andi
            ALUOp = 4'h7;
        end
        6'h0d: begin // ori
            ALUOp = 4'h8;
        end
        6'h0e: begin // xori
            ALUOp = 4'h9;
        end
        6'h0a: begin // slti
            ALUOp = 4'hb;
        end
        6'h0b: begin // sltiu
            ALUOp = 4'hc;
        end
        6'h04: begin // beq
            ALUOp = 4'hd;
        end
        6'h05: begin // bne
            ALUOp = 4'he;
        end
        6'h0f: begin // lui
            ALUOp = 4'hf;
        end
    endcase
end

endmodule
