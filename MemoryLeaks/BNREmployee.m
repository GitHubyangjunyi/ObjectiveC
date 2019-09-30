//
//  BNREmployee.m
//  MemoryLeaks
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

@interface BNREmployee()
{
    NSMutableArray *_assets;                            //移动到类扩展以隐藏可变属性
}

@property (nonatomic) unsigned int officeAlarmCode;


@end

@implementation BNREmployee

-(double)yearsOfEmployment
{
    if (self.hireDate) {
        NSDate *now = [NSDate date];
        NSTimeInterval secs = [now timeIntervalSinceDate: self.hireDate];
        return  secs / 31557600.0;
    } else {
        return 0;
    }
}

-(float)bodyMassIndex
{
    return 0.9 * [super bodyMassIndex];
}

                                                        //因为需要加入一对多关系,先为类增加一个collection对象,这里加入数组,然后将其他对象加入这个collection对象
                                                        //创建这种collection对象的时机有两种
                                                        //1.创建本体BNREmployee对象时
                                                        //2.需要使用相应的collection对象时延迟创建(这里选择后者)
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
