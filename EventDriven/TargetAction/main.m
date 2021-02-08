//
//  main.m
//  TargetAction
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        BNRLogger *logger = [[BNRLogger alloc] init];                                           //创建一个BNRLogger实例并让它成为NSTimer的目标,将它动作设置为updateLastTime
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
                                                                                                //使用@selector语句传递动作消息的名称给相应方法,这就需要传递相应的实参而不能只传递方法的名字
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }
    return 0;
}

//计时器使用的是目标-动作对机制,创建计时器时要设定延迟/目标/动作
//在指定延迟时间后计时器会向目标发送指定的消息
//这里的定时器只完成一项任务,就是在指定的时刻触发时间,所以适合使用目标-动作对实现回调
//很多简单的用户控件(如按钮和滑块)也采用目标-动作对机制
//
//深入学习:选择器的工作机制
//当某个对象收到消息时会向该对象的类进行查询,检查是否有与消息名称相匹配的方法,该查询过程会沿着继承层次结构向上,直到某个类回应"我有与消息名称相匹配的方法"
//方法的查询速度非常快,如果使用实际的方法名进行查询则会变得很慢
//为了提速,编译器会为每个其接触过的方法附上一个唯一的数字(选择器),程序运行时使用的是这个数字而不是方法名
//当一个方法需要一个选择器作为实参时,实际上需要的就是这一个数字,通过编译指令@selector可以得到与方法名相对应的选择器
