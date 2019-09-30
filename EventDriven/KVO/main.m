//
//  main.m
//  KVO
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"
#import "BNRObserver.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc] init];                                           //创建一个BNRLogger实例并让它成为NSTimer的目标,将它动作设置为updateLastTime
        __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:logger selector:@selector(updateLastTime:) userInfo:nil repeats:YES];
                                                                                                //使用@selector语句传递动作消息的名称给相应方法,这就需要传递相应的实参而不能只传递方法的名字
        
        __unused BNRObserver *observer = [[BNRObserver alloc] init];                            //新对象observer用来观察logger的lastTime属性
        
        [logger addObserver:observer forKeyPath:@"lastTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];//无论lastTime何时发生变化都要通知我
        
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

//键值观察是指当指定的对象的属性被修改时,允许对象接收通知的机制,虽然不是很常用,但是这一机制是Cocoa bindings以及Core Data的关键组成部分
//就是告诉一个对象,我想要观察你的fido属性,如果它发生了变化就通知我
//当setFido方法被调用时,被观察的对象会发送消息给你,通知你fido属性有一个新值了
//观察对象的属性时,要指定观察属性的名称,同时还可以指定其他一些东西,比如当属性发生变化时将新的值或旧的值发送给观察者
//需要注意的是,这里的通知和NSNotificationCenter是不一样的,这里讨论的不是NSNotificationCenter或者NSNotification
