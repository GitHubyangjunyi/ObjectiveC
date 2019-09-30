//
//  main.m
//  NS_ENUM
//
//  Created by 杨俊艺 on 2019/9/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    One = 1,
    Two = 2
}BNRNum;

typedef NS_ENUM(char, Numberx) {
    One1,
    Two2
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        printf("%zu\n", sizeof(BNRNum));
        printf("%zu\n", sizeof(Numberx));
        
    }
    return 0;
}

//从OS X10.8和iOS 6开始引入的NS_ENUM()
//NS_ENUM()实际上是一个宏,带有两个实参,数据类型和名字,其中最重要的优点是可以声明数据类型节约空间
//如果使用旧语法,编译器通常选择int类型
