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
@property (nonatomic) NSDate *hireDate;//属性指向对象时需要对内存进行管理,同基本类型的属性一样,该属性会获得一个实例变量名为_hireDate,指向一个NSDate对象
//编译器将会以下合成两个存取方法
//  -(void)setHireDate:(NSDate *)d;
//  -(NSDate *)hireDate;

-(double)yearsOfEmployment;

@end

NS_ASSUME_NONNULL_END
