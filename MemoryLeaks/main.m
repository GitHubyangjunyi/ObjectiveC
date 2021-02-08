//
//  main.m
//  MemoryLeaks
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
        for (int i = 1; i < 11; i++) {
            BNRAsset *asset = [[BNRAsset alloc] init];
            
            //为BNRAsset设置合适的标签
            NSString *currentLabel = [NSString stringWithFormat:@"Latop %d", i];
            asset.label = currentLabel;
            asset.resaleValue = i * 10;
            
            //生成0到9之间的随机数
            NSUInteger randomIndex = random() % [employees count];
            NSLog(@"randomIndex: %lu， %d", (unsigned long)randomIndex, i * 10);
            //取出相应的BNREmployee对象
            BNREmployee *randomEmployee = [employees objectAtIndex:randomIndex];
            
            //将BNRAsset对象赋给该BNREmployee对象
            [randomEmployee addAssets:asset];
        }
        
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of one employee");
        [employees removeObjectAtIndex:5];
        
        
        NSLog(@"employees count = %lu", (unsigned long)[employees count]);
        NSLog(@"Employees[5]: %@", employees[5]);
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of arrays");
        employees = nil;
        //引发一连串释放动作
        //但是凡是拥有BNRAsset对象的BNREmployee对象都没有被释放
        //所有BNRAsset对象也没有被释放
        //这是因为BNRAsset对象拥有BNREmployee对象,BNREmployee对象拥有包含BNRAsset对象的数组对象,该数组对象又拥有BNRAsset对象
        //这种互相拥有的所有权关系导致相关的对象都无法释放的情况称为强引用循环,这是导致内存泄漏的常见原因
        //通过苹果公司提供的性能分析工具Instruments可以找出程序中的强引用循环
        //Product-Profile-Leaks-Allocations(显示柱状图)
        //点击Leaks并在下拉列表选择Cycles& Roots检查强引用循环
    }
    sleep(100);//延长程序运行时间进行性能分析
    return 0;
}
