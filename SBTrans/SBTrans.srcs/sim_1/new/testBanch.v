`timescale 1ns / 1ps
module testBanch(
    );
    reg data_in1;
    reg [15:0] data_in2;
    reg r_w;
    reg ctrl_w;
    reg reset;
    reg clk;
    reg write_en;
    wire data_out1;
    wire [15:0] data_out2;
    wire data_ready;
    wire receive_ready;
    initial begin
        data_in1 = 0;
        data_in2 = 16'b0000_0000_0000_0000;
        r_w = 1'bz;
        ctrl_w = 1;
        reset = 1;
        clk = 0;
        write_en = 0;
        // ÖÃÁã
        reset = 0;
        #1 reset = 1;
        // ²âÊÔ²¢Èë´®³ö
        #10 r_w = 1;
        ctrl_w = 1;
        data_in2 = 16'b0101_0101_0101_0101;
        #5 write_en = 1;
        // ²âÊÔ´®Èë²¢³ö
        #35 r_w = 0; 
        reset = 0;
        #1 reset = 1;
        data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #5 write_en = 1;
        #2 reset = 0;
        #1 reset = 1;
        r_w = 1; 
        ctrl_w = 0;
        data_in2 = 16'b0000_0000_0101_0101;
        #20 reset = 0;
        #1 reset = 1; 
        r_w = 0; 
        data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #2 data_in1 = 0;
        #2 data_in1 = 1;
        #6 reset = 0;
    end
    always
        #1 clk = ~clk;
    sbTrans u1(data_in1,data_in2[15:0],r_w,ctrl_w,reset,clk,write_en,data_out1,data_out2[15:0],data_ready,receive_ready);
endmodule