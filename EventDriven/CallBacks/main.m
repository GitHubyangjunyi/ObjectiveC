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
