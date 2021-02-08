//
//  BNRAppliance.m
//  AppliancesX
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance

@synthesize productName = pName;

- (instancetype)init{
    return [self initWithProductName:@"UnknownName"];
}

// MARK: 指定初始化方法
-(instancetype) initWithProductName:(NSString *)name{
    if (self = [super init]) {
        pName = [name copy];
        _voltage = 120;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %d volts>", self.productName, self.voltage];
}

@end
