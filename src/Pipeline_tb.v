`include "Pipeline_top.v"

module top_tb;

reg clk,rst;
integer i;

Pipeline_top TEST(clk,rst);

initial begin
    clk=1'b0;
    rst=0;
    #20;
    rst=1;
    #300   
    $finish;
end



initial begin
    forever #2 clk=~clk;
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
end


endmodule