//
//  BNRAppliance.m
//  KVC
//
//  Created by 杨俊艺 on 2019/9/5.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance

-(instancetype) initWithProductName:(NSString *)name{
    if (self = [super init]) {
        _productName = [name copy];
        _voltage = 120;
    }
    return self;
}

- (instancetype)init{
    return [self initWithProductName:@"UnknownName"];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %d volts>", _productName, self.voltage];
}

-(void)setVoltage:(int)value{
    NSLog(@"setting voltage to %d", value);
    _voltage = value;
}

@end
