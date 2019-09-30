//
//  main.m
//  BlockReturnValue
//
//  Created by 杨俊艺 on 2019/9/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        double (^divBlock)(double, double);
        
        divBlock = ^(double dividend, double divisor){
            double quotient = dividend / divisor;
            return quotient;
        };
        
        
        NSLog(@"%f", divBlock(20, 5));
        
        
    }
    return 0;
}
