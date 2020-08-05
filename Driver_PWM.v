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
			input ext_clk_25m,	//�ⲿ����25MHzʱ���ź�
			input ext_rst_n,	//�ⲿ���븴λ�źţ��͵�ƽ��Ч
			input [1:0]mode,
			output reg o_pwm	//�����ź�
		);
 
//-------------------------------------
reg[19:0] cnt;		//20λ������
 
	//cnt����������0-999999��ѭ����������ext_clk_25mʱ�ӵ�1000000��Ƶ����Ӧcntһ������Ϊ25Hz
always @ (posedge ext_clk_25m or negedge ext_rst_n)	
	if(!ext_rst_n) cnt <= 20'd0;
	else if(cnt < 20'd999_999) cnt <= cnt+1'b1;
	else cnt <= 20'd0;
 
//-------------------------------------
 
	//����Ƶ��Ϊ25Hz��ռ�ձȲ�ͬ���������岨��
always @ (posedge ext_clk_25m or negedge ext_rst_n) 
	case(mode)
	    2'b00:                                         //ռ�ձ�80%
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd800_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
	    2'b01:                                         //ռ�ձ�60%
	       begin
	          if(!ext_rst_n) o_pwm <= 1'b0;
	          else if(cnt < 20'd600_000) o_pwm <= 1'b1;
	          else o_pwm <= 1'b0;
	       end
        2'b10:                                         //ռ�ձ�40%
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