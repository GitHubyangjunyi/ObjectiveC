//
//  BNREmployee.m
//  WeakReferences
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

@interface BNREmployee()
{
    NSMutableArray *_assets;
}

@property (nonatomic) unsigned int officeAlarmCode;


@end

@implementation BNREmployee

-(double)yearsOfEmployment
{
    if (self.hireDate) {
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate: self.hireDate];
        return  secs / 31557600.0;//每年的秒数
    } else {
        return 0;
    }
}

-(float)bodyMassIndex
{
    return 0.9 * [super bodyMassIndex];
}

-(void)setAssets:(NSArray *)assets
{
    _assets = [assets mutableCopy];
}

-(NSArray *)assets
{
    return [_assets copy];
}

-(void)addAssets:(BNRAsset *)objects
{
    if (!_assets) {
        _assets = [[NSMutableArray alloc] init];
    }
    [_assets addObject:objects];
    objects.holder = self;
}

-(unsigned int)valueOfAssets
{
    unsigned int sum = 0;
    for (BNRAsset *a in _assets) {
        sum += [a resaleValue];
    }
    return sum;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<Employee %u: $%u in assets>", self.employeeID, self.valueOfAssets];
}

-(void)dealloc
{
    NSLog(@"deallocating %@", self);
}

@end
