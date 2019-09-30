//
//  main.m
//  WeakReferences
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNREmployee.h"
#import "BNRAsset.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //创建一个数组用来包含多个BNREmployee对象
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
        
        
        NSLog(@"%lu", (unsigned long)[employees count]);
        NSLog(@"Employees: %@", employees[5]);
        NSLog(@"Employees: %@", employees);
        
        NSLog(@"Giving up ownership of arrays");
        employees = nil;
    }
    return 0;
}

//通过弱引用解决强引用循环问题
//弱引用是不说明所有权的指针,要解决MemoryLeaks项目中的问题就不能让BNRAsset对象拥有它的holder,也就是BNREmployee对象
//编辑BNRAsset.h将holder改成弱引用
//所有对象应该能被正确释放了
//
//如果对象间是父子关系,那么为了避免强引用循环通常需要遵守此规则:
//父对象拥有子对象,但是子对象不拥有父对象
