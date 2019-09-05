//
//  main.m
//  KVC
//
//  Created by 杨俊艺 on 2019/9/5.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRAppliance *oa = [[BNRAppliance alloc] init];
        NSLog(@"%@", oa);
        
        [oa setValue:@"xxxx" forKey:@"productName"];//setValue: forKey:方法会查找名为setProductName:的存方法,如果对象没有setProductName:方法就会直接为实例变量赋值
        NSLog(@"%@", [oa valueForKey:@"productName"]);//valueForKey:方法会查找名为productName的取方法,如果对象没有取方法,则直接返回相应的实例变量
        //KVC能够在么有存取方法的情况下直接读取实例变量,明显违反了对象封装原则
        //如果输错属性名称会在运行时出现错误
        //为什么需要KVC?
        //当苹果公司提供的某个框架需要向你编写的对象写入数据时,会使用setValue: forKey:
        //当苹果公司提供的某个框架需要从你编写的对象读取数据时,会使用valueForKey
        //以Core Data框架为例,能将对象保存在SQL Lite中,并在需要时还原对象,这套框架通过KVC管理数据对象
        
        //非对象类型
        //KVC只对对象有效,但是有些属性的类型不是对象,所以需要使用NSNumber对象
        [oa setVoltage:444];
        NSLog(@"%@", oa);
        
        [oa setValue:[NSNumber numberWithInt:555] forKey:@"voltage"];
        NSLog(@"%@", oa);
        //如果向BNRAppliance实例发送valueForKey:@"voltage",返回的是NSNumber对象
        //
        //KEY路径
        //大部分应用最后都有一个复杂的对象表,遍历关系时就不方便,使用KeyPath简化
        //NSString *str = [oa valueForKeyPath:@"manager.emergencyContact.phoneNumber"];
        
        
        
        
    }
    return 0;
}
