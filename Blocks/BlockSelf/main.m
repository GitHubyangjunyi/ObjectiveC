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
        
        //修改外部变量
        __block int counter = 0;                //__block关键字是必需的
        void (^counterBlock)(void) = ^{ counter++; };
        
        counterBlock();
        counterBlock();
        
        NSLog(@"%d", counter);
    }
    return 0;
}

//Block对象通常会在其代码中使用外部创建的其他变量(基本类型的变量或者指向其他对象的指针),这些外部创建的变量变量叫做外部变量
//当执行Block对象时,为了确保外部变量能够始终存在,相应的Block对象会捕获这些变量
//
//对基本类型的变量,捕获意味着程序会拷贝变量的值,并用Block对象内的局部变量保存
//对指针类型的变量,Block对象会使用强引用,意味着凡是Block对象用到的对象都会被保留,所以在相应的Block对象被释放前,这些对象一定不会被释放
//这也是Block对象与函数的区别,函数无法做到这点
//
//在Block中使用self要多做几步工作来避免强引用循环,比如BNREmployee创建了一个Block对象,每次执行时打印自己
//  myBlock = ^{
//      NSLog(@"Employee: %@", self);
//  };
//
//BNREmployee有一个指向Block对象的指针,这个Block捕获self,有个指回BNREmployee实例的指针,导致强引用循环
//
//解决方法:
//在Block外部声明弱引用指向self
//
//__weak BNRPerson *weakSelf = self;    //外部弱引用
//  myBlock = ^{
//      NSLog(@"Employee: %@", weakSelf);
//  };
//
//现在这个Block对象对实例是弱引用,打破强引用循环
//但是由于是弱引用,所以self指向的对象在Block执行时可能被释放,所以要
//
//__weak BNRPerson *weakSelf = self;    //外部弱引用
//myBlock = ^{
//    BNRPerson *innerSelf = weakSelf;  //局部强引用,Block执行完消失
//    NSLog(@"%@", innerSelf);
//}
//
//在Block对象中无意捕获self
//如果直接在Block对象中使用实例变量,那么Block会捕获self,而不会捕获实例变量
//
//__weak BNRPerson *weakSelf = self;    //外部弱引用
//myBlock = ^{
//    BNRPerson *innerSelf = weakSelf;  //局部强引用,Block执行完消失
//    NSLog(@"%@", innerSelf);
//    NSLog(@"Employee ID: %d", _employeeID);
//}
//
//编译器如此解读
//__weak BNRPerson *weakSelf = self;    //外部弱引用
//myBlock = ^{
//    BNRPerson *innerSelf = weakSelf;  //局部强引用,Block执行完消失
//    NSLog(@"%@", innerSelf);
//    NSLog(@"Employee ID: %d", self->_employeeID);//无意捕获导致强引用循环
//}
//
//解决方法
//__weak BNRPerson *weakSelf = self;    //外部弱引用
//myBlock = ^{
//    BNRPerson *innerSelf = weakSelf;  //局部强引用,Block执行完消失
//    NSLog(@"%@", innerSelf);
//    NSLog(@"Employee ID: %d", innerSelf.employeeID);//使用存取方法替换直接存取实例变量
//}
//
//
//修改外部变量
//在Block对象中,被捕获的变量是常数,程序无法修改变量所保存的值
//如果需要在Block对象中修改某个外部变量,则可以在声明相应的外部变量时在前面加上__block关键字
