//
//  main.m
//  BlockImplementBlockForwarding
//
//  Created by 杨俊艺 on 2019/10/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        __block int val = 0;
        
        void (^blk) (void) = [^{++val;} copy];
        
        
        ++val;
        
        blk();
        
        printf("val = %d\n", val);
        
        NSLog(@"%d", val);
        
        
        
        
        
        
    }
    return 0;
}
