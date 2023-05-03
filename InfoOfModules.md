# **The Main structure of CPU**
![CPU Structure](./cpu.png)

# **Moudles Of the CPU**


## **PC_Module**
### Function: get the address of instruction
### Input: Address[31:0]
### Output: Address[31:0](To Instruction_Memory_Module and Add_Module)
### Clk: Pre negedge

## **Instruction_Memory_Module**
### Function: Use the address to find the instruction
### Input: Address[31:0](From PC_Module)
### Output: Instruction[31:0](To Control_Module, Registers_Module and Sign-extend_Module)
### Clk: posedge

## **Control_Module**
### Function: Recognise what's the type of this instruction and control other modules for correct operation 
### Input: Instruction[31:26](From Instruction_Memory_Module)
### Output: RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite
### Clk: no clk

## **Registers_Module**
### Function: Get the value from registers or rewrite the value of registers
### Input: Read_Register1[5:0](From Instruction[25:21]), Read_Register[5:0](From Instruction[20:16]), Write_register[5:0](From Mux1_Module), Write_Data[31:0](From Mux3_Module), RegWrite(From Control_Module)
### Output: Read_data1[31:0](To ALU_Module), Read_data2[31:0](To Mux2_Module and Data_Memory_Module)
### Clk: negedge

## **ALU_Module**
### Function: Implement multiple sets of arithmetic and logical operations
### Input: Operator1[31:0](From Registers_Module), Operator2[31:0](From Mux2_Module), ALU_Control_Signal(From ALU_Control_Module)
### Output: Result[31:0](To Mux3_Module and Data_Memory_Module), Zero
### Clk: No clk

## **Data_Memory_Module**
### Function: Store and get data from memory
### Input: Address[31:0](From ALU_Module), Write_data[31:0](From Registers_Module), MemWrite(From Control_Module), MemRead(From Control_Module)
### Output: Read_Data[31:0](To Mux3)
### Clk: next posedge

## **Mux1_Module**
### Function: Decide which one is the Write_Register
### Input: Data1[4:0](From Instruction_Memory_Module), Data2[4:0](From Instruction_Memory_Module), RegDst(From Control_Module)
### Output: Write_Register[4:0](To Registers_Module)
### Clk: No clk

## **Mux2_Module**
### Function: Decide which one is the second operator for ALU_Module
### Input: Data1[31:0](From Registers_Module), Data2[31:0](From Sign-Extend_Module), ALUSrc(From Control_Module)
### Output: Operator[31:0](To ALU_Module)
### Clk: No clk

## **Mux3_Module**
### Function: Decide which one should be writen to the register
### Input: Data1[31:0](From Data_Memory_Module), Data2[31:0](From ALU Module), MemtoReg(From Control_Module)
### Output: Write_Data[31:0](To Registers_Module)
### Clk: No clk

## **Mux4_Module**
### Function: Decide which one is the next PC Address
### Input: Data1[31:0](From Add_Module), Data2[31:0](From Add_Module), Control_Signal(From Control and ALU)
### Output: Address[31:0](To PC_Module)
### Clk: No clk

## **Add_Module**
### Function: Add two numbers
### Input: Data1[31:0], Data2[31:0]
### Output: Result[31:0]
### Clk: No clk

## **Sign-Extend_Module**
### Function: Extend a 16-bits number to 32bits number
### Input: Data[16:0](From Instruction_Memory_Module)
### Output: Result[31:0](To Mux2_Module)
### Clk: No clk

## **ALU_Control_Module**
### Function: Tell ALU how to calculate
### Input: ALUOp(From Control_Module), Funct[5:0](From Instruction[5:0])
### Output: ALU_Control_Signal(To ALU_Module)
### Clk: No clk