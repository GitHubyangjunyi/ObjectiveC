//
//  RGBS.m
//  RGBS
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "RGBS.h"
#import <stdio.h>
#import "RGB.h"

static unsigned char roundUChar(int v)
{
    if (v < 0) {
        return 0;
    }
    if (v > 255) {
        return 255;
    }
    return (unsigned char)v;
}

@implementation RGBS

- (id)initWithRed: (int)r green: (int)g blue: (int)b
{
    if ((self = [super init]) != nil) {
        red = roundUChar(r);
        green = roundUChar(g);
        blue = roundUChar(b);
    }
    return self;
}

- (id)blendColor: (RGBS *)color
{
    red = ((unsigned int)red + color->red) / 2;
    green = ((unsigned int)green + color->green) / 2;   //因为类型一致，如果color是别的类(就算是父类)的对象则不能使用这种->方法直接访问color内部的实例变量并且color声明类型必须是静态类型
    blue = ((unsigned int)blue + color->blue) / 2;
    return self;
}

//访问受限制
//- (id)blendColorX: (RGB *)color
//{
//    red = ((unsigned int)red + color->red) / 2;
//    green = ((unsigned int)green + color->green) / 2;
//    blue = ((unsigned int)blue + color->blue) / 2;
//    return self;
//}

- (void)print
{
    printf("(%d, %d, %d)\n", red, green, blue);
}

@end
