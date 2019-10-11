//
//  main.m
//  CString
//
//  Created by 杨俊艺 on 2019/9/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        char *greeting = "Hello!";
        NSString *nsstr = [NSString stringWithCString:greeting encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@\n", nsstr);
        
        
        NSString *gx = @"Hello!";
        const char *rx = NULL;
        if ([gx canBeConvertedToEncoding:NSUTF8StringEncoding]) {       //在将NSString对象转换成C字符串时要考虑编码问题,因为某些NSString对象能够保存的字符,C字符串可能不支持,所以要先检查
            rx = [gx cStringUsingEncoding:NSUTF8StringEncoding];        //程序不拥有cStringUsingEncoding:方法返回的字符串,系统会负责管理其内存并保证在autoreleasepool被排空之前一定存在
        }                                                               //如果要保留更久就应该使用malloc分配一块内存再将C字符串拷贝进去
        
        
        char x = 0x21;      //!
        while (x <= 0x7e) { //~
            printf("%x is %c\n", x, x);
            x++;
        }
    }
    
    return 0;
}
