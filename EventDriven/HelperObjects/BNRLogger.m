//
//  BNRLogger.m
//  HelperObjects
//
//  Created by 杨俊艺 on 2019/9/2.
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

-(void)updateLastTime:(NSTimer *)t                             //动作方法总是有一个实参,它是传入发送动作消息的那个对象,这里是NSTimer对象
{
    NSDate *now = [NSDate date];
    [self setLastTime:now];
    NSLog(@"Just set time to %@", self.lastTime);
}

                                                                                    //作为NSURLConnection的委托对象,BNRLogger需要响应三条消息,其中两条来自NSURLConnectionDataDelegate协议
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data       //收到一定字节数的数据后会被调用
{
    NSLog(@"received %lu bytes", (unsigned long)[data length]);
    if (!_incomingData) {
        _incomingData = [[NSMutableData alloc] init];
    }
    [_incomingData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;                    //最后一部分数据处理完毕后会被调用
{
    NSLog(@"Finished!");
    NSString *string = [[NSString alloc] initWithData:_incomingData encoding:NSUTF8StringEncoding];
    _incomingData = nil;
    NSLog(@"string has %lu characters", [string length]);
    NSLog(@"string is %@", string);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error   //获取数据失败时会被调用
{
    NSLog(@"connection failed: %@", [error localizedDescription]);
    _incomingData = nil;
}

@end
