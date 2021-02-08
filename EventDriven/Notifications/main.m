//
//  main.m
//  Notifications
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRLogger *logger = [[BNRLogger alloc] init];
        
        //将logger注册成为观察者使之在时区设置发生变化时收到通知
        [[NSNotificationCenter defaultCenter] addObserver:logger selector:@selector(zoneChange:) name:NSSystemTimeZoneDidChangeNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSSystemTimeZoneDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *nsnotifiction){NSLog(@"Block: The system time zone has changed!");} ];
        
        
        [[NSRunLoop currentRunLoop] run];
        
        
    }
    return 0;
}

//当用户修改了系统时区设置时,程序中的很多对象可能需要知道这一变化,这些对象都可以通过通知中心将自己注册成为观察者observer
//当系统时区设置变化时会向通知中心发布NSSystemTimeZoneDidChangeNotification通知,然后通知中心会将该通知转发给相应的观察者
//在向通知中心注册观察者时可以指定某个特定的通知名(如NSWindowDidResizeNotification)以及通知发布的来源(只接收到这个窗口调整大小的通知),这两个参数都可以设置为nil,如果都设置为nil那么就会接收到程序中所有对象发布的每条通知
//
//关于如何选择?
//1.对于只做一件事的对象,例如NSTimer,选择目标-动作对
//2.对于复杂功能使用辅助对象
//3.对于要触发多个(其他对象中的)回调的对象,使用通知
//
//回调与对象所有权
//无论哪种类型的回调,如果代码不正确则有陷入强循环引用的风险
//常常发生这种情况:
//  创建的对象拥有一个指向回调对象的指针,而这个回调对象的指针指向你创建的对象,导致强引用循环,两个对象都无法释放
//所以在编写代码时遵守以下规则:
//1.通知中心不拥有观察者,如果将某个对象注册为观察者,通常应该在释放该对象时将其移出通知中心
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//2.对象不拥有委托对象或数据源对象,如果某个新创建的对象是另一个对象的委托对象或数据源对象,那么该对象应该在其dealloc方法中取消相应关联
//-(void)dealloc
//{
//    [windowThatBossesMeAround setDelegate:nil];
//    [tableViewThatBegsForData setDataSource:nil];
//}
//
//3.对象不拥有目标,如果某个新创建的对象是另一个对象的目标,那么该对象应该在其dealloc方法中将相应的目标指针赋为nil
//-(void)dealloc
//{
//    [buttonThatKeepsSendingMeMessages setTarget:nil];
//}
//
//因为BNRLogger对象不会在程序终止前被释放,所以不存在以上问题,非常侥幸的是程序碰巧使用了两个例外情况
//NSURLConnection对象会保留其委托对象
//NSTimer会保留其目标
//
//
//Block对象简化
//addObserverForName: object: queue: usingBlock:
//该方法要求传入一个Block对象,当指定的通知发生时,通知中心就会执行这个Block对象,而不是与观察者打交道,意味着修改后的程序永远不会调用zoneChange:方法
//传入的Block对象需要一个参数,类型为NSNotification *
//queue可以传入nil,这个与并发相关
//这里两处的代码都会执行
