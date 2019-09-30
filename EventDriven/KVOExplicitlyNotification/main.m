//
//  main.m
//  KVOExplicitlyNotification
//
//  Created by 杨俊艺 on 2019/9/29.
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

//显式触发通知
//如果使用存取方法设置属性,系统会自动通知观察者,但如果出于某些原因不使用存取方法呢?
//这时可以通过willChangeValueForKey:和didChangeValueForKey:方法通知系统某个属性的值即将/已经发生变化
//更改代码在文件BNRLogge.m中
//    [self willChangeValueForKey:@"lastTime"];         //这两句注释掉将无法触发通知
//    _lastTime = now;
//    [self didChangeValueForKey:@"lastTime"];         //这两句注释掉将无法触发通知
