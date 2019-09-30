//
//  BNRLogger.m
//  Notifications
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRLogger.h"

@implementation BNRLogger

-(NSString *)lastTimeString
{
    static NSDateFormatter *dateFormatter = nil;                //如果有一千个BNRLogger实例,使用一样的方式格式化字符串,那么你希望所有的BNRLogger实例都能共享一个NSDateFormatter
    if (!dateFormatter) {                                       //许多面向对象语言都使用类变量而不是实例变量来处理这种问题,Objective-C使用静态变量
        dateFormatter =[[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLog(@"created dateFormatter");
    }
    return [dateFormatter stringFromDate:self.lastTime];
}

-(void)updateLastTime:(NSTimer *)t                              //动作方法总是有一个实参,它是传入发送动作消息的那个对象,这里是NSTimer对象
{
    NSDate *now = [NSDate date];
    [self setLastTime:now];
    NSLog(@"Just set time to %@", self.lastTime);
}

-(void)zoneChange:(NSNotification *)note
{
    NSLog(@"The system time zone has changed!");
}

@end
