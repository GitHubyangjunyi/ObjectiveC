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

//alloc负责分配空间,init负责初始化对象,其中init是实例方法,返回的是初始化后的对象地址
//因为BNRAppliance没实现init方法,所以新创建的BNRAppliance实例,_productName是nil,voltage是0
