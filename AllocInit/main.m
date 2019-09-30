//
//  main.m
//  AllocInit
//
//  Created by 杨俊艺 on 2019/8/30.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //唯一必须以嵌套形式连续发送的消息是alloc和init
        //每个类都有一个alloc方法,能够创建一个新的对象并返回该对象的指针
        //通过alloc创建的对象必须初始化,否则无法接收消息
        
        NSDate *now = [[NSDate alloc] init];
        NSLog(@"This NSDate object lives at %p", now);
        NSLog(@"This date is %@", now);
        
        //当声明指向对象的指针时,通常都会明确地写出相应对象的类,但是可能会碰到👇的情况
        //声明指针时并不知道所指对象的类型
        //👉使用id类型:可以指向任意类型的Objective-C对象的指针
        //id delegate;//id隐含星号的作用
        
        
//        NSDate *currentTime = nil;
//        NSLog(@"currentTime's value is %p", currentTime);
        
        NSDate *currentTime = [NSDate date];
        NSLog(@"currentTime's value is %p", currentTime);
        
        //Sleep(2);
        
        currentTime = [NSDate date];
        NSLog(@"currentTime's value is %p", currentTime);//两次输出地址不一样
                                                        //从代码角度看丢失了第一个对象的指针,即使还在堆上
        
        NSDate *cTime = [NSDate date];
        NSLog(@"cTime's value is %p", cTime);
        
        NSDate *xTime = cTime;
        NSLog(@"xTime's value is %p", xTime);
        
        cTime = nil;
        NSLog(@"cTime's value is %p", cTime);
        NSLog(@"xTime's value is %p", xTime);
        
        
        NSString *list = @"abc the xcv ght";
        NSString *name = @"the";
        NSString *nname = @"eh";
        
        NSRange match = [list rangeOfString: name];
        if (!(match.location == NSNotFound)) {
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }else{
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }
        match = [list rangeOfString: nname];
        if (!(match.location == NSNotFound)) {
            NSLog(@"%lu", (unsigned long)match.location);
            NSLog(@"%lu", (unsigned long)match.length);
        }else{
            NSLog(@"Not Found");
            NSLog(@"%lu", (unsigned long)match.length);
        }
        
        //ARC:每个对象都会对指向自己的指针进行计数
        //ARC:每个对象都会对指向自己的指针进行计数
        //ARC:每个对象都会对指向自己的指针进行计数
        //使用ARC只能通过增加或减少对对象的引用数来保留或销毁对象,只有当引用数为0时才会被销毁
        //如果不再需要某个对象,可以将指向它的指针设置为nil或者销毁它的指针
    }
    return 0;
}
