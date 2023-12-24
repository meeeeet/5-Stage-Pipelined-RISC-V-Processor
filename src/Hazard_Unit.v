module Hazard_Unit(
    rst, RS1E,RS2E, ForwardAE, ForwardBE, RDM, RegWriteM, RDW, RegWriteW
);

input [4:0] RS1E, RS2E, RDM, RDW;
input rst, RegWriteM, RegWriteW;
output [1:0] ForwardAE,ForwardBE;

assign ForwardAE = (rst == 1'b0) ? 2'b00 : 
                    ((RegWriteM == 1'b1) & (RDM != 5'h00) & (RDM == RS1E)) ? 2'b10 :
                    ((RegWriteW == 1'b1) & (RDW != 5'h00) & (RDW == RS1E)) ? 2'b01 : 2'b00;
                       
assign ForwardBE = (rst == 1'b0) ? 2'b00 : 
                ((RegWriteM == 1'b1) & (RDM != 5'h00) & (RDM == RS2E)) ? 2'b10 :
                ((RegWriteW == 1'b1) & (RDW != 5'h00) & (RDW == RS2E)) ? 2'b01 : 2'b00;

endmodule