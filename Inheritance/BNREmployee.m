//
//  Employee.m
//  Inheritance
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNREmployee.h"

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

-(NSString *)description
{
    return [NSString stringWithFormat:@"<Employee %d>", self.employeeID];
}

@end
