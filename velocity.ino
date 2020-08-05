#include <PinChangeInt.h>      //外部中断头文件
#include <MsTimer2.h>        //定时中断头文件
#include "I2Cdev.h"        
#include "Wire.h"  

#define ENCODER 2 
#define DIRECTION 3

volatile long Velocity= 0;   //编码器数据
int Velocity_out = 0;     //输出

void control()           //每5ms定时中断一次进入控制函数
{
  static int Velocity_Count, Encoder_Count;
  sei();            //全局中断开启
  if (++Velocity_Count >= 8)    //周期40ms
  {
    Velocity_out = Velocity;    Velocity = 0;  //读取轮编码器数据，并清零
    Velocity_Count = 0;
  }
}

void READ_ENCODER() {                //函数功能为边沿除法外部中断读取编码器数据
  if (digitalRead(ENCODER) == LOW) {     //如果是下降沿触发的中断
    if (digitalRead(DIRECTION) == LOW)      Velocity--;  //根据另外一相电平判定方向
    else      Velocity++;
  }
  else {     //如果是上升沿触发的中断
    if (digitalRead(DIRECTION) == LOW)      Velocity++; //根据另外一相电平判定方向
    else     Velocity--;
  }
}

void setup() {              //初始化函数
  pinMode(2, INPUT);       //编码器A引脚
  pinMode(3, INPUT);       //编码器B引脚
  Serial.begin(9600);
  delay(1500);
  MsTimer2::set(5, control);    //使用Timer2设置5ms定时中断
  MsTimer2::start();          //使用中断使能
  attachInterrupt(0, READ_ENCODER, CHANGE);           //开启外部中断 编码器接口1
 }

void loop() {
    Serial.begin(9600);      //开启串口，设置波特率为 9600
    Serial.print(abs(Velocity_out / 2));   //输出数据
    Serial.print("}$");
    delay(50);
}
