//
//  main.m
//  CallBacks
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"
#import "BNRObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //创建一个BNRLogger实例并让它成为NSTimer的目标,将它动作设置为updateLastTime
        BNRLogger *logger = [[BNRLogger alloc] init];
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
        //使用@selector语句传递动作消息的名称给相应方法,这就需要传递相应的实参而不能只传递方法的名字
        
        
        //从这里开始看
        //事件驱动的程序需要有一个对象,专门负责等待事件的发生
        //NSRunLoop实例会持续等待,当特定事件发生时就像相应的对象发送消息
        //NSRunLoop实例会在特定事件发生时触发回调
        
        //KVO
        __unused BNRObserver *observer = [[BNRObserver alloc] init];
        
        [logger addObserver:observer forKeyPath:@"lastTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];//无论lastTime何时发生变化都要通知我
        
        [[NSRunLoop currentRunLoop] run];
        //至此创建了一个运行循环,下面实现回调
        //计时器使用的是目标-动作对机制,创建计时器时要设定延迟/目标/动作
        //在指定延迟时间后计时器会向目标发送指定的消息
        //然后向上看
        
  
        
        
        
        
        
        
        
        
        
    }
    return 0;
}

//回调就是将一段代码和一个特定的事件帮顶起来,当特定的事件发生就会执行这段代码
//在Objective-C中有四种方法可以实现回调
//1.目标-动作对  target-action
//  在程序开始等待前,要求当事件发生时向指定的对象发送某个特定的消息,接受消息的对象是目标,消息的选择器是动作
//2.扶助对象
//  在程序开始等待前,要求当事件发生时向遵守相应协议的辅助对象发送消息,委托对象和数据源是常见的辅助对象
//3.通知
//  苹果公司提供了一种称为通知中心的对象,在程序开始等待前可以告知通知中心某个对象正在等待某些特定的通知,当其中的某个通知出现时向指定的对象发送特定的消息
//  当事件发生时,相关的对象会向通知中心发布通知,然后再由通知中心将通知转发给正在等待该通知的对象
//4.Block对象
//  Block是一段可执行代码,在程序开始等待前声明一个Block对象,当事件发生时执行这段Block对象
