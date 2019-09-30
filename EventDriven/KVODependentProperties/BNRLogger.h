//
//  BNRLogger.h
//  KVODependentProperties
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRLogger : NSObject

@property (nonatomic) NSDate *lastTime;

-(NSString *)lastTimeString;
-(void)updateLastTime:(NSTimer *)t;             //动作方法总是有一个实参,它是传入发送动作消息的那个对象,这里是NSTimer对象

@end

NS_ASSUME_NONNULL_END
