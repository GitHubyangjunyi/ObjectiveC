//
//  main.m
//  AppliancesX
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"
#import "BNROwnedAppliance.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRAppliance *obj = [[BNRAppliance alloc] init];
        NSLog(@"init obj is %@", obj);
        [obj setVoltage:200];
        [obj setProductName:@"Washing Machine"];
        NSLog(@"set obj is %@", obj);
        
        BNRAppliance *unknown = [[BNRAppliance alloc] init];
        NSLog(@"%@", unknown);
        [unknown setProductName:@"Max"];
        NSLog(@"%@", unknown);
        
        
        BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] init];
        NSLog(@"%@", oa);
        
    }
    return 0;
}
