//
//  main.m
//  Appliances
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRAppliance *obj = [[BNRAppliance alloc] init];
        NSLog(@"init obj is %@", obj);
        [obj setVoltage:200];
        [obj setProductName:@"Washing Machine"];
        NSLog(@"set obj is %@", obj);
        
    }
    return 0;
}
