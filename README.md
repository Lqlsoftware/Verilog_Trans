# Verilog_Trans
实现了串并行转换
### 输入信号
1.ctrl_w 控制输入位数 1:16位/0:8位
2.r_w 控制串行输入并行输出/并行输入串行输出
3.write_en 输入信号是否允许输出
4.datain1 串行输入
5.datain2[16:0] 并行输入
### 输出信号
1.dataReady 并行数据转换完成信号
2.receiveReady 串行输入接受完成
3.dataout1 串行输出
4.dataout2[16:0] 并行输出
