//
//  BNRLogger.h
//  Notifications
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRLogger : NSObject

@property (nonatomic) NSDate *lastTime;

-(NSString *)lastTimeString;
-(void)updateLastTime:(NSTimer *)t;

-(void)zoneChange:(NSNotification *)note;

@end

NS_ASSUME_NONNULL_END
