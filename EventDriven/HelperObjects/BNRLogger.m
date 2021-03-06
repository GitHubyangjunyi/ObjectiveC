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
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter =[[NSDateFormatter alloc] init];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLog(@"created dateFormatter");
    }
    return [dateFormatter stringFromDate:self.lastTime];
}

-(void)updateLastTime:(NSTimer *)t
{
    NSDate *now = [NSDate date];
    [self setLastTime:now];
    NSLog(@"Just set time to %@", self.lastTime);
}

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
