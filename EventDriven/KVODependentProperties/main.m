//
//  main.m
//  KVODependentProperties
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
        
        //[logger addObserver:observer forKeyPath:@"lastTime" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];//无论lastTime何时发生变化都要通知我
        [logger addObserver:observer forKeyPath:@"lastTimeString" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
                                            //改为lastString
        
        [[NSRunLoop currentRunLoop] run];
        
    }
    return 0;
}

//独立属性
//如果不想观察_lastTime而想观察_lastString呢?
//运行程序会发现观察者并没有正确收到通知,系统不知道当_lastTime发生变化时_lastString也会变化
//为了修复这个问题,可以告诉系统_lastTime会影响_lastString,实现一个类方法来做这项工作
//类方法实现在BNRLogger.m中,无需在BNRLogger.h中声明这个类方法,系统会在运行时找到它
//
//+(NSSet *)keyPathsForValuesAffectingLastTimeString
//{
//    return [NSSet setWithObject:@"lastTime"];
//}
//
//方法的名字是keyPathsForValuesAffecting加上首字母大写的键的名字,类似属性的存方法是set加上首字母大写的属性名
