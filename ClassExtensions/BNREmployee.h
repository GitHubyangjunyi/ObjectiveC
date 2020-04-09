//
//  BNREmployee.h
//  ClassExtensions
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

NS_ASSUME_NONNULL_BEGIN

@class BNRAsset;

@interface BNREmployee : BNRPerson
//{
//    NSMutableArray *_assets;//移动到类扩展以隐藏可变属性
//}
@property (nonatomic) unsigned int employeeID;
//@property (nonatomic) unsigned int officeAlarmCode;       //移动到实现文件中成为类扩展
@property (nonatomic) NSDate *hireDate;
@property (nonatomic, copy) NSArray *assets;      //分别声明一个属性和一个实例变量实例变量的类型和属性的类型就可以不一样
                                            //NSArray类型的含义是告诉其他类,如果询问我的assets就会得到一些不可变的对象,然而assets数组实际上是NSMutableArray实例,所以可以在BNREmployee.m文件中增加或者移除元素
-(double)yearsOfEmployment;
-(void)addAssets:(BNRAsset *)objects;
-(unsigned int)valueOfAssets;

@end

NS_ASSUME_NONNULL_END
