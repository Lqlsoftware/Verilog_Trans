`timescale 1ns / 1ps
module sbTrans(
    // 串行输入
    input data_in1,
    // 并行输入
    input [15:0] data_in2,
    // 控制串行/并行输入 1:并行输入 0:串行输入
    input r_w,
    // 控制并行输入输出8/16位 1:16位 0:8位
    input ctrl_w,
    // 重置 低电平有效
    input reset,
    // 时钟
    input clk,
    // 允许输入
    input write_en,
    // 串行输出
    output reg data_out1,
    // 并行输出
    output reg [15:0]  data_out2,
    // 数据转换完成
    output reg data_ready,
    // 数据接收完成
    output reg receive_ready
    );
    
    integer counter;
    reg [15:0] temp;
    
    always @(posedge clk or negedge reset) begin
        if (reset == 0) begin
            data_out1 = 0;
            data_out2 = 0;
            receive_ready = 0;
            data_ready = 0;
            counter = 0;
            temp = 0;
        end
        // 并行输入串行输出
        else if (r_w == 1) begin
            // 16进制
            if (ctrl_w == 1) begin
                // 并行输入
                if (receive_ready == 0) begin
                    temp[15:0] = data_in2[15:0];
                    receive_ready = 1;
                    counter = 0;
                end
                // 串行输出
                else if (write_en == 1 && counter < 16) begin
                    data_out1 = temp[0];
                    temp = temp>>1;
                    counter = counter + 1;
                end
                else if (counter > 15)
                    receive_ready = 0;
            end
            // 8进制
            else begin
                // 并行输入
                if (receive_ready == 0) begin
                    temp[7:0] = data_in2[7:0];
                    receive_ready = 1;
                    counter = 0;
                end
                // 串行输出
                else if (write_en == 1 && counter < 8) begin
                    data_out1 = temp[0];
                    temp = temp >> 1;
                    counter = counter + 1;
                end
                else if (counter > 7)
                    receive_ready = 0;
            end
            
        end
        // 串行输入并行输出
        else begin
            // 16进制
            if (ctrl_w == 1) begin
                // 串行输入
                if (data_ready == 0 && counter < 16) begin
                    temp[0] = data_in1;
                    temp = temp << 1;
                    counter = counter + 1;
                end
                // 并行输出
                else if (data_ready == 1 && write_en == 1) begin
                    data_out2[15:0] = temp[15:0];
                    data_ready = 0;
                    counter = 0;
                end
                else if (counter > 15)
                    data_ready = 1;
            end
            // 8进制
            else begin
                // 串行输入
                if (data_ready == 0 && counter < 8) begin
                    temp[0] = data_in1;
                    temp = temp << 1;
                    counter = counter + 1;
                end
                // 并行输出
                else if (data_ready == 1 && write_en == 1) begin
                    data_out2[7:0] = temp[7:0];
                    data_ready = 0;
                    counter = 0;
                end
                else if (counter > 7)
                    data_ready = 1;
            end
        end
    end

endmodule