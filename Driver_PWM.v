`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 10:45:25
// Design Name: 
// Module Name: Driver_PWM
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


module Driver_PWM(
			input ext_clk_25m,	//外部输入25MHz时钟信号
			input ext_rst_n,	//外部输入复位信号，低电平有效
			input [1:0]mode,
			output reg o_pwm	//控制信号
		);
 
//-------------------------------------
reg[19:0] cnt;		//20位计数器
 
	//cnt计数器进行0-999999的循环计数，即ext_clk_25m时钟的1000000分频，对应cnt一个周期为25Hz
always @ (posedge ext_clk_25m or negedge ext_rst_n)	
	if(!ext_rst_n) cnt <= 20'd0;
	else if(cnt < 20'd999_999) cnt <= cnt+1'b1;
	else cnt <= 20'd0;
 
//-------------------------------------
 
	//产生频率为25Hz，占空比不同的周期脉冲波形
always @ (posedge ext_clk_25m or negedge ext_rst_n) 
	case(mode)
	    2'b00:                                         //占空比80%
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd800_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
	    2'b01:                                         //占空比60%
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd600_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
        2'b10:                                         //占空比40%
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd400_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
	    default:
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd000_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
	    endcase
endmodule