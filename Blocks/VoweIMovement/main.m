//
//  main.m
//  VoweIMovement
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *originalString = @[@"Sauerkraut", @"Raygun", @"Big Nerd Ranch", @"Mississippi"];//保存最初的字符串对象
        NSArray *vowels = @[@"a", @"e", @"i", @"o", @"u"];                                       //保存需要从字符串中移除的字符
        NSMutableArray *devowelizedStrings = [NSMutableArray array];                             //保存去除元音字母后的版本
        NSLog(@"original string: %@", originalString);
        

        void (^devowelizer)(id, NSUInteger, BOOL *);    //这个Block的类型是一个有着三个参数并且没有返回值的Block对象,这是enumerateObjectsUsingBlock:方法期望的Block类型
                                                        //第一个实参是对象指针指向当前枚举的对象,第二个实参类型是当前对象在数组中的索引,第三个实参是指向BOOL变量的指针,默认值是NO,如果设置为YES则数组对象会在执行完当前Block对象后终止循环

        devowelizer = ^(id string, NSUInteger i, BOOL *stop){//复制原始字符串并移除原始字符串中的所有元音字母,然后将去除了元音字母的字符串保存到devowelizedStrings数组中,最后赋值给devowelizer
            
            NSMutableString *newString = [NSMutableString stringWithString:string];     //此时的newstring来源于当前正在枚举的那个字符串
            
            //枚举数组中的字符串,将所有出现的元音字母替换成空字符串
            for (NSString *s in vowels) {
                NSRange fullRange = NSMakeRange(0, [newString length]);
                [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
            }
            [devowelizedStrings addObject:newString];
        };
        
        
        [originalString enumerateObjectsUsingBlock:devowelizer];
        NSLog(@"new string: %@", devowelizedStrings);
        
        
        
        
        
        
        NSMutableArray *devowelizedStringsx = [NSMutableArray array];
        
        void (^devowelizerx)(id, NSUInteger, BOOL *) = ^(id string, NSUInteger i, BOOL *stop){
                    
                    //检查当前枚举的字符串是否包含y,如果有则设置指针指向YES,那么数组对象会在执行完当前的Block对象后终止枚举过程
                    NSRange yRange = [string rangeOfString:@"y" options:NSCaseInsensitiveSearch];
                    if (yRange.location != NSNotFound) {
                        *stop = YES;
                        return;
                    }
                    
                    NSMutableString *newString = [NSMutableString stringWithString:string];     //此时的newstring来源于当前正在枚举的那个字符串
                    
                    //枚举数组中的字符串,将所有出现的元音字母替换成空字符串
                    for (NSString *s in vowels) {
                        NSRange fullRange = NSMakeRange(0, [newString length]);
                        [newString replaceOccurrencesOfString:s withString:@"" options:NSCaseInsensitiveSearch range:fullRange];
                    }
                    [devowelizedStringsx addObject:newString];
                };
                
                
                [originalString enumerateObjectsUsingBlock:devowelizerx];
                NSLog(@"new string: %@", devowelizedStringsx);
        
    }
    return 0;
}

//VoweIMovement将使用Block对象枚举数组中的字符串并移除所有的元音字母,并将去除了元音字母的字符串保存到一个新的数组中
//enumerateObjectsUsingBlock:方法要求传入的Block对象是三个实参类型是固定的
//第一个是对象指针指向当前枚举的对象
//第二个参数是NSUInteger,是当前对象在数组中的索引
//第三个参数是指向BOOL变量的指针,默认是0,如果指针指向YES,那么数组对象会在执行完当前的Block对象后终止枚举过程
//
//typedef
typedef void (^devowelizer)(id, NSUInteger, BOOL *);
//跟在^后面的是类型名称
//void (^devowelizer)(id, NSUInteger, BOOL *);
//相当于
devowelizer blockVar;
