//
//  main.m
//  NSRunLoop
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        [[NSRunLoop currentRunLoop] run];
        //至此创建了一个运行循环,下面实现回调
        
        
    }
    return 0;
}

//回调就是将一段代码和一个特定的事件绑定起来,当特定的事件发生时就会执行这段代码
//在Objective-C中有四种方法可以实现回调
//1.目标-动作对  target-action
//  在程序开始等待前,要求当事件发生时向指定的对象发送某个特定的消息,接受消息的对象是目标,消息的选择器(selector)是动作(action)
//2.辅助对象
//  在程序开始等待前,要求当事件发生时向遵守相应协议的辅助对象发送消息,委托对象(delegate)和数据源(data source)是常见的辅助对象
//3.通知
//  苹果公司提供了一种称为通知中心的对象,在程序开始等待前可以告知通知中心某个对象正在等待某些特定的通知,当其中的某个通知出现时向指定的对象发送特定的消息
//  当事件发生时,相关的对象会向通知中心发布通知,然后再由通知中心将通知转发给正在等待该通知的对象
//4.Block对象
//  Block是一段可执行代码,在程序开始等待前声明一个Block对象,当事件发生时执行这段Block对象
//
//
//事件驱动的程序需要有一个对象,专门负责等待事件的发生,OS X系统和iOS系统有一个运行循环NSRunLoop
//NSRunLoop实例会持续等待,当特定事件发生时就向相应的对象发送消息
//NSRunLoop实例会在特定事件发生时触发回调
