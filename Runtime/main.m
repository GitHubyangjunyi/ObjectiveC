//
//  main.m
//  Runtime
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <objc/runtime.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *array = [[NSArray alloc] init];
        NSLog(@"%hhd\n", [array respondsToSelector:@selector(sortedArrayUsingSelector:)]);  //自省
                                            //询问自己有没有实现sortedArrayUsingSelector:方法
        
        
        
        NSString *liteName = @"Hello!";
        NSString *capsName = [liteName uppercaseString];            //相当于下面的语句
        //NSString *capsName = objc_msgSend(liteName, @selector(uppercaseString));
        NSLog(@"%@ -> %@", liteName, capsName);
        
        
        
                                                                    //Objective-C运行时不仅负责记录正在使用哪些类,还负责记录那些包含到程序中的库以及框架使用的类
        unsigned int classCount = 0;                                //用来保存注册的类的数量
        Class *classList = objc_copyClassList(&classCount);         //返回的指针指向当前加载的所有注册类的列表,通过引用返回注册类的数量,objc_copyClassList会返回一个由指向类对象指针组成的C数组
        
        for (int i = 0; i < classCount; i++) {                      //列出表单中的每一个类
            Class currentClass = classList[i];                          //将类的列表当成C数组进行处理
            
            NSLog(@"%@", NSStringFromClass(currentClass));              //将类的名称作为字符串进行处理并输出类的名称
        }
        free(classList);                                            //释放类列表缓冲区
        
    }
    return 0;
}
