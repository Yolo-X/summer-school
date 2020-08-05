`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 10:46:34
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg rst;
    reg clk;
    reg [1:0]mode;
    wire o_pwm;
    Driver_PWM Diver_PWM(
        .ext_clk_25m(clk),
        .ext_rst_n(rst),
        .mode(mode),
        .o_pwm(o_pwm)
        );
    initial
        begin
            clk=0;
            rst=0;
            mode=2'b10;
            #50;
            rst=1;
            #40000000 mode=2'b00;
            #40000000 mode=2'b01;
        end     
        always #5 clk=~clk;
endmodule
