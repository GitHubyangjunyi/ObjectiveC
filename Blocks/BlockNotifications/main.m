//
//  main.m
//  BlockNotifications
//
//  Created by 杨俊艺 on 2019/9/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        [[NSNotificationCenter defaultCenter] addObserverForName:NSSystemTimeZoneDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *nsnotifiction){NSLog(@"Block: The system time zone has changed!");} ];
        
        
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}

//addObserverForName: object: queue: usingBlock:
//该方法要求传入一个Block对象,当指定的通知发生时,通知中心就会执行这个Block对象,而不是与观察者打交道,意味着修改后的程序永远不会调用zoneChange:方法
//传入的Block对象需要一个参数,类型为NSNotification *
//queue可以传入nil,这个与并发相关
