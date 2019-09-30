//
//  main.m
//  Categories
//
//  Created by 杨俊艺 on 2019/9/29.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+BNRVowelCounting.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *string = @"Hello, World!";
        NSLog(@"%@ has %d vowels", string, [string bnr_vowelCount]);
        
        
    }
    return 0;
}

//通过使用范畴,程序员可以为任何已有的类添加方法,以苹果公司提供的NSString为例,虽然没有NSString源码,但是借助范畴就能为NSString添加新的方法
//实现使用范畴的方法时,如果在类中已经存在相同名称的另一个方法,范畴方法将会替换之前存在的方法
//应该使用范畴增加方法,而不是替换已经存在的方法,要进行替换的情况下应该创建子类
