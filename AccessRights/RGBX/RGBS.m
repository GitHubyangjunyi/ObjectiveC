//
//  RGBS.m
//  RGBX
//
//  Created by 杨俊艺 on 2019/11/10.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

#import "RGBS.h"
#import <stdio.h>

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

- (id)initWithRed: (int)r green: (int)g blue: (int)b pui: (int)pu;
{
    if ((self = [super init]) != nil) {
        red = roundUChar(r);
        green = roundUChar(g);
        blue = roundUChar(b);
        pui = pu;
    }
    return self;
}


- (id)blendColor: (RGB *)color
{
    red = ((unsigned int)red + color->red) / 2;
    green = ((unsigned int)green + color->green) / 2;
    blue = ((unsigned int)blue + color->blue) / 2;
    pui = ((int)pui + color->pui) / 2;
    return self;
}

- (void)print
{
    printf("(%d, %d, %d, %d)\n", red, green, blue, pui);
}

@end
