//
//  main.m
//  IsAPointer
//
//  Created by 杨俊艺 on 2019/9/1.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        
        
        
    }
    return 0;
}

//NSObject虽然有很多方法,但是只有一个实例变量:isa指针
//任何一个对象的isa指针都会指向创建该对象的类,所有对象都知道自己是被哪个类创建的
//给对象发送消息时,对象会通过isa指针查询是否有该消息名的方法
//如果没有则继续查询父类,以此类推,直到达到继承链顶端NSObject
//
//程序会执行首先找到的方法,如果是子类实例发送消息并找到,搜索到达父类之前就结束了
//但是使用super就等于告诉对象运行指定的方法,但是从对象的父类开始搜索与之匹配的实现
//
//处理%@时程序会先向相应的指针变量所指的对象发送description消息
//description会返回一个描述类实例的字符串,默认的NSObject会以字符串的形式返回对该对象在内存上的地址
//然而内存地址并不能有效进行描述,类可以覆盖description方法
//NSDate覆盖为返回实例保存的日期/时间
