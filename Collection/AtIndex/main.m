//
//  main.m
//  AtIndex
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSDate *now = [NSDate date];
        NSDate *tomorrow = [now dateByAddingTimeInterval:24.0 * 60 * 60];
        NSDate *yesterday = [now dateByAddingTimeInterval:-24.0 * 60 * 60];
        
        NSMutableArray *dateList = [NSMutableArray array];
        [dateList addObject: now];
        [dateList addObject: tomorrow];
        
        [dateList insertObject:yesterday atIndex:0];
        
        for (NSDate *d in dateList) {
            NSLog(@"%@\n", d);
        }
        
        NSLog(@"%lu", (unsigned long)[dateList count]);
        
        [dateList removeObjectAtIndex:0];
        NSLog(@"%lu", (unsigned long)[dateList count]);
        
        NSLog(@"%@", dateList[0]);
    }
    return 0;
}
