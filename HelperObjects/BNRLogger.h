//
//  BNRLogger.h
//  HelperObjects
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRLogger : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>//声明会实现这两个协议

{
    NSMutableData *_incomingData;
}

@property (nonatomic) NSDate *lastTime;

-(NSString *)lastTimeString;
-(void)updateLastTime:(NSTimer *)t;//动作方法总是有一个实参,是传入发送动作消息的那个对象,这里是NSTimer对象

//作为NSURLConnection的委托对象,BNRLogger需要响应三条消息,其中两条来自NSURLConnectionDataDelegate协议
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;//收到一定字节数的数据时会被调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection;//最后一部分数据处理完毕后会被调用

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;//获取数据失败时会被调用

-(void)zoneChange:(NSNotification *)note;

@end

NS_ASSUME_NONNULL_END
