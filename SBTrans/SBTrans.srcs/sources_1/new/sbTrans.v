`timescale 1ns / 1ps
module sbTrans(
    // ��������
    input data_in1,
    // ��������
    input [15:0] data_in2,
    // ���ƴ���/�������� 1:�������� 0:��������
    input r_w,
    // ���Ʋ����������8/16λ 1:16λ 0:8λ
    input ctrl_w,
    // ���� �͵�ƽ��Ч
    input reset,
    // ʱ��
    input clk,
    // ��������
    input write_en,
    // �������
    output reg data_out1,
    // �������
    output reg [15:0]  data_out2,
    // ����ת�����
    output reg data_ready,
    // ���ݽ������
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
        // �������봮�����
        else if (r_w == 1) begin
            // 16����
            if (ctrl_w == 1) begin
                // ��������
                if (receive_ready == 0) begin
                    temp[15:0] = data_in2[15:0];
                    receive_ready = 1;
                    counter = 0;
                end
                // �������
                else if (write_en == 1 && counter < 16) begin
                    data_out1 = temp[0];
                    temp = temp>>1;
                    counter = counter + 1;
                end
                else if (counter > 15)
                    receive_ready = 0;
            end
            // 8����
            else begin
                // ��������
                if (receive_ready == 0) begin
                    temp[7:0] = data_in2[7:0];
                    receive_ready = 1;
                    counter = 0;
                end
                // �������
                else if (write_en == 1 && counter < 8) begin
                    data_out1 = temp[0];
                    temp = temp >> 1;
                    counter = counter + 1;
                end
                else if (counter > 7)
                    receive_ready = 0;
            end
            
        end
        // �������벢�����
        else begin
            // 16����
            if (ctrl_w == 1) begin
                // ��������
                if (data_ready == 0 && counter < 16) begin
                    temp[0] = data_in1;
                    temp = temp << 1;
                    counter = counter + 1;
                end
                // �������
                else if (data_ready == 1 && write_en == 1) begin
                    data_out2[15:0] = temp[15:0];
                    data_ready = 0;
                    counter = 0;
                end
                else if (counter > 15)
                    data_ready = 1;
            end
            // 8����
            else begin
                // ��������
                if (data_ready == 0 && counter < 8) begin
                    temp[0] = data_in1;
                    temp = temp << 1;
                    counter = counter + 1;
                end
                // �������
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