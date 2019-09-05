//
//  BNREmployee.h
//  WeakReferences
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNRPerson.h"

NS_ASSUME_NONNULL_BEGIN

@class BNRAsset;//使用@class而不是#import时编译器不会查看文件的全部,提高处理速度

@interface BNREmployee : BNRPerson

//添加一对多关系
//{
//    NSMutableArray *_assets;//移动到类扩展以隐藏可变属性
//}

@property (nonatomic) unsigned int employeeID;
//@property (nonatomic) unsigned int officeAlarmCode;//移动到实现文件中成为类扩展
@property (nonatomic) NSDate *hireDate;//属性指向对象时需要对内存进行管理,同基本类型的属性一样,该属性会获得一个实例变量名为_hireDate,指向一个NSDate对象
//编译器将会以下合成两个存取方法
//  -(void)setHireDate:(NSDate *)d;
//  -(NSDate *)hireDate;
@property (nonatomic, copy) NSArray *assets;//NSArray类型的含义是告诉其他类,如果询问我的assets就会得到一些不可变的对象,然而assets数组实际上是NSMutableArray实例,所以可以在BNREmployee.m文件中增加或者移除元素
//这也就是为什么分别声明一个属性和一个实例变量,这样属性和实例变量的类型就可以不同

-(double)yearsOfEmployment;
-(void)addAssets:(BNRAsset *)objects;
-(unsigned int)valueOfAssets;

@end

NS_ASSUME_NONNULL_END
