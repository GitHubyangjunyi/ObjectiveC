//
//  main.m
//  BlockSelf
//
//  Created by 杨俊艺 on 2019/9/4.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRPerson.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //在Block对象中被捕获的变量是常数,程序无法修改变量保存到值,加上__block成为可修改
        //修改外部变量
        __block int counter = 0;
        void (^counterBlock)(void) = ^{
            counter++;
        };
        
        counterBlock();
        counterBlock();
        
        NSLog(@"%d", counter);
        
        
        
        
        
    }
    return 0;
}

//Block对象通常会在其代码中使用外部创建的其他变量,当执行Block对象时,为了确保外部变量能够始终存在,相应的Block对象会捕获这些变量
//对基本类型的变量,捕获意味着程序会拷贝变量的值,并用Block对象内的局部变量保存
//对指针类型的变量,Block对象会使用强引用,意味着凡是Block对象用到的对象都会被保留,所以在相应的Block独享被释放前,这些对象不会被释放
//这也是Block对象与函数的区别,函数无法做到这点
//
//在Block中使用self导致的强引用循环
//在Block外部声明弱引用指向self
//
//__weak BNRPerson *weakSelf = self;//外部弱引用
//myBlock = ^{
//    BNRPerson *innerSelf = weakSelf;//强引用执行完消失
//    NSLog(@"%@", innerSelf);
//}
//
//在Block对象中无意识使用self
//如果直接在Block对象中使用实例变量,那么Block会捕获self,而不会捕获实例变量
