//
//  BNRAppliance.m
//  Appliances
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRAppliance.h"

@implementation BNRAppliance

- (instancetype)init{
    return [self initWithProductName:@"UnknownName"];//覆盖父类的init方法并用定向至initWithProductName:方法以避免使用旧init方法是导致的问题
}

// MARK: 指定初始化方法
-(instancetype) initWithProductName:(NSString *)name{
    if (self = [super init]) {
        _productName = [name copy];
        _voltage = 120;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %d volts>", self.productName, self.voltage];
}

@end

//返回instancetype类型的值,这个值告诉编译器方法返回什么类型的对象,任何自己编写初始化方法都应该返回instancetype类型值
//因为返回BNRAppliance的指针就会在子类化时导致问题,在Xcode 4.3以前使用id作为返回类型
//检查父类的初始化方法的用处:
//1.出于优化考虑,init方法会释放已经分配了内存的对象,然后创建一个新对象并返回(这种情况苹果公司要求将父类的init方法所返回的对象赋给self)
//2.init执行过程中发生错误,所以会释放对象并返回nil(这种情况苹果公司建议检查返回值)
