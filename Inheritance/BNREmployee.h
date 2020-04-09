//
//  Employee.h
//  Inheritance
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNREmployee : BNRPerson

@property (nonatomic) unsigned int employeeID;
@property (nonatomic) unsigned int officeAlarmCode;
@property (nonatomic) NSDate *hireDate;

-(double)yearsOfEmployment;

@end

NS_ASSUME_NONNULL_END
