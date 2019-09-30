//
//  main.m
//  CopyMutableCopy
//
//  Created by 杨俊艺 on 2019/9/27.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *str = @"testStr";
        NSMutableString *mutableStr = [str mutableCopy];//如果这里使用copy下面的添加字符串修改动作将crash
        NSLog(@"%@, %p", str, str);
        [mutableStr appendString:@"123"];
        NSLog(@"%@, %p", mutableStr, mutableStr);
        //两个地址不一样
        NSLog(@"");
        
        
        
        NSMutableString *mStr = [NSMutableString stringWithFormat:@"mutableStr"];
        NSMutableString *mStrmutableCopy = [mStr mutableCopy];//这里也不能使用copy
        [mStrmutableCopy appendString:@"123"];
        NSLog(@"%@, %p", mStr, mStr);
        NSLog(@"%@, %p", mStrmutableCopy, mStrmutableCopy);
        //两个地址也不一样
        NSLog(@"");
        
        
        
        NSMutableString *mstr = [NSMutableString stringWithFormat:@"mutableStr"];
        NSString *str1 = [mstr copy];
        NSLog(@"%@, %p", mstr, mstr);
        NSLog(@"%@, %p", str1, str1);
        //两个地址也不一样
        NSLog(@"");
        
        
        NSString *str2 = @"str";
        NSString *copyStr2 = [str2 copy];
        NSLog(@"%@, %p",str2, str2);
        NSLog(@"%@, %p",copyStr2, copyStr2);
        //两个都是不可变对象,地址一样
        NSLog(@"");
        
        
        
        NSString *str3 = @"str";
        NSString *copyStr3 = [str2 mutableCopy];//深拷贝
        NSLog(@"%@, %p",str3, str3);//和str2地址一样
        NSLog(@"%@, %p",copyStr3, copyStr3);
        //两个都是不可变对象,地址却不一样
        
        
        NSString *str4 = @"str4";
        NSString *str44 = [str4 copy];
        str4 = @"asdf";
        NSLog(@"\nstr4 = %@ str4P = %p \n str44 = %@ str44P = %p", str4, str4, str44, str44);
        //但是copy还有它的特点
        //修改源对象的属性和行为不会影响副本对象
        //修改副本对象的属性和行为不会影响源对象
        
        
    }
    return 0;
}

//是否是深浅拷贝,是否创建新的对象是由程序运行的环境所造成的并不能一概而论
//浅拷贝不会生成新的对象,所以系统会对以前的对象进行一次retain,深拷贝会产生新的对象,系统不会对以前的对象进行retain
//
//接着我们来看下copy与Block的配合使用
//Block默认存储在栈中,栈中的Block访问到的外界对象,不会对应进行retain
//Block如果在堆中,在Block中访问了外界的对象,会对外界的对象进行一次retian
//因为Block在什么时候执行是不确定的,所以如果Block里外部对象被提前释放了,那么如果这时候block执行了造成野指针异常,程序crash
//所以对于Block来说我们一般都用copy关键字修饰
//#import <Foundation/Foundation.h>
//
//typedef void(^TestBlock)(NSString * str);
//
//@interface Model : NSObject
//
//@property (nonatomic,copy) TestBlock testblock;
//
//@end
//使用copy保存Block可以保住Block中,避免以后调用block的时候,外界的对象已经释放了
//
//
//
//来自Objective-C编程书上的内容P183
//NSArray的copy方法仅仅返回指针的指针
//NSMutableArray的copy方法则制作一份自己的拷贝并返回指向新数组对象的指针
//
//来自Objective-C编程书上的内容P292
//属性copy修饰
//copy特性要求拷贝传入的对象,并将新对象赋给实例变量
//有些类有两个版本,一个是可修改版本,一个是不可修改版本,无论哪一个版本
//copy方法都返回不可修改版本,例如
//NSMutableString的copy返回NSString实例,如果要拷贝出可修改版本就应该使用mutableCopy
//
//Objective-C没有为属性提供mutableCopy特性,如果某个存方法需要复制传入的对象,并且要求新对象是可以修改的,就必须自己编写代码,向传入的对象发送mutbleCopy消息,而不能依赖属性机制
