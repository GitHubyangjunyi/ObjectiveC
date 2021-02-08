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
        
        //使用NSNumber包装C语言基本类型
        NSMutableArray *list = [[NSMutableArray alloc] init];
        [list addObject:@4];
        
        //使用NSValue封装结构体
        NSPoint somePoint = NSMakePoint(100, 100);
        NSValue *pointValue = [NSValue valueWithPoint:somePoint];
        [list addObject:pointValue];
        NSLog(@"%lu", (unsigned long)[list count]);
        
        
        //使用NSNull
        [list addObject:[NSNull null]];
        NSLog(@"%lu", (unsigned long)[list count]);
        
        
    }
    return 0;
}
