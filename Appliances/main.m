//
//  main.m
//  Appliances
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRAppliance.h"
#import "BNROwnedAppliance.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        BNRAppliance *obj = [[BNRAppliance alloc] init];
        NSLog(@"%d", [obj voltage]);
        NSLog(@"%@", [obj productName]);
        
        BNRAppliance *unknown = [[BNRAppliance alloc] init];
        NSLog(@"%@", unknown);
        [unknown setProductName:@"Max"];
        NSLog(@"%@", unknown);
        
        
        BNROwnedAppliance *oa = [[BNROwnedAppliance alloc] init];
        NSLog(@"%@", oa);
        
        [oa setValue:@"xxxx" forKey:@"productName"];//setValue: forKey:方法会查找名为setProductName:的存方法,如果对象没有setProductName:方法就会直接为实例变量赋值
        NSLog(@"%@", [oa valueForKey:@"productName"]);//valueForKey:方法会查找名为productName的取方法,如果对象没有取方法,则直接返回相应的实例变量
        //KVC能够在么有存取方法的情况下直接读取实例变量
        //如果输错属性名称会在运行时出现错误
        //为什么需要KVC?
        //当苹果公司提供的某个框架需要向你编写的对象写入数据时,会使用setValue: forKey:
        //当苹果公司提供的某个框架需要从你编写的对象读取数据时,会使用valueForKey
        //以Core Data框架为例,能将对象保存在SQL Lite中,并在需要时还原对象,这套框架通过KVC管理数据对象
        
        
        
        
        
        
        
        
        
        
        
        
    }
    return 0;
}

//alloc负责分配空间,init负责初始化对象,其中init是实例方法,返回的是初始化后的对象地址
//因为BNRAppliance没实现init方法,所以新创建的BNRAppliance实例,_productName是nil,voltage是0
