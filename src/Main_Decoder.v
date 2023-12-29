// module Main_Decoder(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,ALUOp);
//     input [6:0]Op;
//     output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
//     output [1:0]ImmSrc,ALUOp;

//     assign RegWrite = (Op == 7'b0000011 | Op == 7'b0110011 | Op == 7'b0010011 ) ? 1'b1 :
//                                                               1'b0 ;
//     assign ImmSrc = (Op == 7'b0100011) ? 2'b01 : 
//                     (Op == 7'b1100011) ? 2'b10 :    
//                                          2'b00 ;
//     assign ALUSrc = (Op == 7'b0000011 | Op == 7'b0100011 | Op == 7'b0010011) ? 1'b1 :
//                                                             1'b0 ;
//     assign MemWrite = (Op == 7'b0100011) ? 1'b1 :
//                                            1'b0 ;
//     assign ResultSrc = (Op == 7'b0000011) ? 1'b1 :
//                                             1'b0 ;
//     assign Branch = (Op == 7'b1100011) ? 1'b1 :
//                                          1'b0 ;
//     assign ALUOp = (Op == 7'b0110011) ? 2'b10 :
//                    (Op == 7'b1100011) ? 2'b01 :
//                                         2'b00 ;

// endmodule

// /***
// 	Name: Main Decoder
// 	Description: This unit generates the control signals from the 7 bit opcode.
// 	Determines the type of instruction


// ***/

module Main_Decoder(
	input [6:0] Op,
	output [1:0] ResultSrc,
	output MemWrite,
	output Branch, ALUSrcA, 
	output [1:0] ALUSrcB,
	output RegWrite, Jump,
	output [2:0] ImmSrc,
	output [1:0] ALUOp
);
	
reg [13:0] controls;
assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;

always @ (*)
	case(Op)
	// RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump
		7'b0000011: controls = 14'b1_000_0_01_0_01_0_00_0; // lw
		7'b0100011: controls = 14'b0_001_0_01_1_00_0_00_0; // sw
		7'b0110011: controls = 14'b1_xxx_0_00_0_00_0_10_0; // R–type
		7'b1100011: controls = 14'b0_010_0_00_0_00_1_01_0; // B-type
		7'b0010011: controls = 14'b1_000_0_01_0_00_0_10_0; // I–type ALU
		7'b1101111: controls = 14'b1_011_0_00_0_10_0_00_1; // jal
		7'b0010111: controls = 14'b1_100_1_10_0_00_0_00_0; // auipc // PC Target for SrcB
		7'b0110111: controls = 14'b1_100_1_01_0_00_0_00_0; // lui
		7'b1100111: controls = 14'b1_000_0_01_0_10_0_00_1; // jalr
		7'b0000000: controls = 14'b0_000_0_00_0_00_0_00_0; // for default values on reset
		
		default: 	controls = 14'bx_xxx_x_xx_x_xx_x_xx_x; // instruction not implemented
	endcase
endmodule