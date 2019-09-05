//
//  BNREmployee.m
//  ClassExtensions
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "BNREmployee.h"
#import "BNRAsset.h"

@interface BNREmployee()
{
    NSMutableArray *_assets;//移动到类扩展以隐藏可变属性
    
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
}

-(unsigned int)valueOfAssets
{
    //累加物品的转售价值
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

//通常类扩展添加在类实现文件中,实现方法@implementation之上
//对非BNREmployee实例对象来说,唯一可见的接口是BNREmployee头文件,因为officeAlarmCode是在类扩展中声明的,所以对非BNREmployee实例不可见
//
//关于隐藏可变属性_assets
//在BNREmployee.h中声明了一个assets属性,是一个NSArray对象,一个addAsset:方法和一个_assets实例变量,是一个NSMutableArray对象
//开发者会在头文件公布属性和实例变量,但不确定是否希望非BNREmployee实例对象或者其他开发者使用它们
//这时候使用类扩展将_assets实例变量移动到类扩展中,这时大家都知道assets是一个NSArray实例,非BNREmployee对象就要使用addAsset:方法来操作这个数组
//实际上它是一个NSMutableArray实例,可变版本的assets实例只有BNREmployee对象知道
//
//头文件与类扩展
//子类无法获取父类的类扩展,BNREmployee是BNRPerson的子类,会导入父类的头文件BNRPerson.h
//因此BNREmployee知道在BNRPerson头文件声明的内容,但无法知道BNRPerson的类扩展中声明的内容
//
//头文件与生成的实例变量
//在类的头文件声明属性的时候,其他对象只能看到属性的存取方法
//非BNREmployee对象,包括其子类无法直接获取属性声明生成的实例变量
//例如在BNRPerson.h中声明了属性
//@property (nonatomic) NSMutableArray *friends;
//在BNREmployee.m中即使BNREmployee是BNRPerson的子类,也不能获取到_friends实例变量
//[_friends addObject:@"Susan"];    //错误
//但是可以使用它的存取方法
//[self.friends addObject:@"Susan"];
