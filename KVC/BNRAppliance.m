//
//  BNRAppliance.m
//  KVC
//
//  Created by 杨俊艺 on 2019/9/5.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance

- (instancetype)init{
    return [self initWithProductName:@"UnknownName"];//覆盖父类的init方法并用定向至initWithProductName:方法以避免使用旧init方法是导致的问题
}

-(instancetype) initWithProductName:(NSString *)name{
    if (self = [super init]) {
        _productName = [name copy];
        _voltage = 120;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %d volts>", _productName, self.voltage];
}

-(void)setVoltage:(int)x{
    NSLog(@"setting voltage to %d", x);
    _voltage = x;
}

@end
