//
//  main.m
//  BlockCapture
//
//  Created by 杨俊艺 on 2019/10/9.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        int val = 0;
        
        const char *fmt = "val = %d\n";
        
        void (^blk) (void) = ^{printf(fmt, val);};//Block截获所使用的的自动变量的瞬时值
        
        val = 2;
        fmt = "These values were changed. val = %d\n";
        
        blk();
        
        
        
        
        
        __block int var = 0;                    //添加修饰符使得可以在Block中进行改写
        
        void (^blkvar) (void) = ^{ var = 1;};
        
        var = 2;
        
        blkvar();
        printf("var = %d\n", var);
        
    }
    return 0;
}

//Block截获所使用的的自动变量的瞬时值
