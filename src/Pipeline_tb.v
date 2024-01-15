`include "Pipeline_top.v"

module top_tb;

reg clk1,clk2,rst;
reg clk3=0;
integer i;

Pipeline_top TEST(clk3,clk3,rst);

initial begin
    clk1=1'b0;
    clk2=1'b0;
    rst=0;
    #20;
    rst=1;
    #30000  
    $finish;
end

initial begin
    forever #1 clk3=~clk3;
end



initial begin
    forever begin
        #1 clk1=1;
        #4 clk1=0;
        #5;
    end
end
initial begin
    #1
    forever begin
        #5 clk2=1;
        #4 clk2=0;
        #1;
    end
end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars();
end


endmodule