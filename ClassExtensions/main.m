//
//  main.m
//  ClassExtensions
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNREmployee.h"
#import "BNRAsset.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *employees = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            BNREmployee *mikey = [[BNREmployee alloc] init];
            
            mikey.weightInKilos = 90 + i;
            mikey.heightInMeters = 1.8 - i / 10.0;
            mikey.employeeID = i;
            [employees addObject:mikey];
        }
        
        //创建10个BNRAsset对象
        for (int i = 0; i < 10; i++) {
            BNRAsset *asset = [[BNRAsset alloc] init];
            
            //为BNRAsset设置合适的标签
            NSString *currentLabel = [NSString stringWithFormat:@"Latop %d", i];
            asset.label = currentLabel;
            asset.resaleValue = 350 + i * 10;
            
            //生成0到9之间的随机数
            NSUInteger randomIndex = random() % [employees count];
            NSLog(@"randomIndex: %lu", (unsigned long)randomIndex);
            //取出相应的BNREmployee对象
            BNREmployee *randomEmployee = [employees objectAtIndex:randomIndex];
            
            //将BNRAsset对象赋给该BNREmployee对象
            [randomEmployee addAssets:asset];
        }
        
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of one employee");
        [employees removeObjectAtIndex:5];
        //当程序将索引为5的BNREmployee对象移除数组时会因为该对象不再有拥有方而将其释放,其包含的所有BNRAsset对象也会因为没有拥有方而被释放
        //虽然没有相应的日志输出,但是可以确定被释放的BNRAsset对象的label属性(NSString实例)也会被释放
        
        NSLog(@"Giving up ownership of arrays");
        employees = nil;
        //引发一连串释放动作
        
    }
    return 0;
}

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
